import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/domain/usecases/local/app/GetTutorialViewedUseCase.dart';
import 'package:menuboss/domain/usecases/remote/file/PostUploadMediaImageUseCase.dart';
import 'package:menuboss/domain/usecases/remote/file/PostUploadMediaVideoUseCase.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/features/main/media/provider/MediaListProvider.dart';
import 'package:menuboss/presentation/features/main/media/widget/FilterButton.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleIcon.dart';
import 'package:menuboss_common/components/bottom_sheet/BottomSheetFilterSelector.dart';
import 'package:menuboss_common/components/button/FloatingPlusButton.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/ClickableScale.dart';
import 'package:menuboss_common/components/view_state/EmptyView.dart';
import 'package:menuboss_common/components/view_state/FailView.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/tutorial/model/TutorialKey.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/FilePickerUtil.dart';
import 'package:menuboss_common/utils/UiState.dart';
import 'package:menuboss_common/utils/dto/Pair.dart';

import '../widget/provider/TutorialProvider.dart';
import 'provider/MediaUploadProvider.dart';
import 'widget/MediaItem.dart';
import 'widget/MediaUploadProgress.dart';

class MediaScreen extends HookConsumerWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaState = ref.watch(mediaListProvider);
    final mediaManager = ref.read(mediaListProvider.notifier);
    final mediaList = useState<List<ResponseMediaModel>?>(null);
    final tutorialManager = ref.read(tutorialProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        mediaManager.updateFilterKeys(FilterInfo.getFilterKey(context));
      });
      return () {
        Future(() {
          mediaManager.init();
          mediaManager.initPageInfo();
        });
      };
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          mediaState.when(
            success: (event) {
              mediaList.value = event.value;
            },
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [mediaState]);

    void doMediaUploadAction() async {
      final uploadProgressProvider = ref.read(mediaUploadProgressProvider.notifier);
      final getTutorialViewedUseCase = GetIt.instance<GetTutorialViewedUseCase>();
      FilePickerUtil.pickFile(
        onImageSelected: (XFile xFile) async {
          final controller = await uploadProgressProvider.uploadStart(
            xFile.path,
            isVideo: false,
            onNetworkError: () {
              Toast.showError(context, getString(context).messageNetworkRequired);
            },
          );
          if (controller != null) {
            GetIt.instance<PostUploadMediaImageUseCase>()
                .call(xFile.path, streamController: controller)
                .then((response) async {
              if (response.status == 200) {
                mediaManager.initPageInfo();
                mediaManager.requestGetMedias();
                uploadProgressProvider.uploadSuccess();
                bool hasViewed = await getTutorialViewedUseCase.call(TutorialKey.MediaAddedKey);
                if (!hasViewed) {
                  tutorialManager.change(TutorialKey.MediaAddedKey, 1.0);
                }
              } else {
                Toast.showError(context, response.message);
                uploadProgressProvider.uploadFail();
              }
            });
          }
        },
        onVideoSelected: (XFile xFile) async {
          final controller = await uploadProgressProvider.uploadStart(
            xFile.path,
            isVideo: true,
            onNetworkError: () {
              Toast.showError(context, getString(context).messageNetworkRequired);
            },
          );
          if (controller != null) {
            GetIt.instance<PostUploadMediaVideoUseCase>()
                .call(xFile.path, streamController: controller)
                .then((response) async {
              if (response.status == 200) {
                mediaManager.initPageInfo();
                mediaManager.requestGetMedias();
                uploadProgressProvider.uploadSuccess();
                bool hasViewed = await getTutorialViewedUseCase.call(TutorialKey.MediaAddedKey);
                if (!hasViewed) {
                  tutorialManager.change(TutorialKey.MediaAddedKey, 1.0);
                }
              } else {
                Toast.showError(context, response.message);
                uploadProgressProvider.uploadFail();
              }
            });
          }
        },
        notAvailableFile: () {
          Toast.showSuccess(context, getString(context).messageFileNotAllowed404);
        },
        onError: (message) {
          Toast.showError(context, message);
        },
        errorPermissionMessage: getString(context).messagePermissionErrorPhotos,
      );
    }

    return SafeArea(
      child: Column(
        children: [
          TopBarIconTitleIcon(
            leadingIsShow: false,
            content: getString(context).mainNavigationMenuMedia,
            suffixIcons: [
              Pair(
                "assets/imgs/icon_new_folder.svg",
                () {
                  mediaManager.createFolder();
                },
              ),
              Pair(
                "assets/imgs/icon_check_round.svg",
                () {
                  Navigator.push(
                    context,
                    nextSlideVerticalScreen(
                      RoutingScreen.SelectMediaFile.route,
                    ),
                  );
                },
              ),
            ],
            onBack: () => popPageWrapper(context: context),
          ),
          Expanded(
            child: Column(
              children: [
                const MediaUploadProgress(),
                Expanded(
                  child: Stack(
                    children: [
                      if (mediaState is Failure && mediaList.value == null)
                        FailView(onPressed: () => mediaManager.requestGetMedias())
                      else if (mediaList.value != null)
                        _MediaContentList(
                          items: mediaList.value!,
                          onMediaUpload: () => doMediaUploadAction(),
                        )
                      else if (mediaState is Success<List<ResponseMediaModel>>)
                        _MediaContentList(
                          items: mediaState.value,
                          onMediaUpload: () => doMediaUploadAction(),
                        ),
                      if (mediaState is Loading) const LoadingView(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MediaContentList extends HookConsumerWidget {
  final List<ResponseMediaModel> items;
  final VoidCallback onMediaUpload;

  const _MediaContentList({
    super.key,
    required this.items,
    required this.onMediaUpload,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaManager = ref.read(mediaListProvider.notifier);
    final scrollController = useScrollController(keepScrollOffset: true);

    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent * 0.7 <= scrollController.position.pixels) {
          mediaManager.requestGetMedias();
        }
      });
      return null;
    }, []);

    return items.isNotEmpty
        ? Stack(
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FilterButton(
                      filterValues: FilterInfo.getFilterValue(context),
                      onSelected: (type, text) {
                        mediaManager.changeFilterType(type,
                            filterValue: FilterInfo.getFilterValue(context));
                      },
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        mediaManager.initPageInfo();
                        mediaManager.requestGetMedias(delayed: 300);
                      },
                      color: getColorScheme(context).colorPrimary500,
                      backgroundColor: getColorScheme(context).white,
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(24, 0, 12, 100),
                        controller: scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final isFolderType = item.type?.code.toLowerCase() == "folder";
                          return ClickableScale(
                            onPressed: () async {
                              if (isFolderType) {
                                Navigator.push(
                                  context,
                                  nextSlideHorizontalScreen(
                                    RoutingScreen.MediaDetailInFolder.route,
                                    parameter: item,
                                  ),
                                );
                              } else {
                                try {
                                  final newName = await Navigator.push(
                                    context,
                                    nextSlideHorizontalScreen(
                                      RoutingScreen.MediaInfo.route,
                                      parameter: item,
                                    ),
                                  );

                                  if (!CollectionUtil.isNullEmptyFromString(newName)) {
                                    mediaManager.renameItem(item.mediaId ?? "", newName);
                                  }
                                } catch (e) {
                                  debugPrint(e.toString());
                                }
                              }
                            },
                            child: MediaItem(
                              item: item,
                              onRemove: () async {
                                final isRemoved = await mediaManager.removeItem([item.mediaId]);
                                if (isRemoved) {
                                  Toast.showSuccess(
                                      context, getString(context).messageRemoveMediaSuccess);
                                }
                              },
                              onRename: (newName) {
                                mediaManager.renameItem(item.mediaId, newName);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(bottom: 16, right: 24),
                child: FloatingPlusButton(
                  onPressed: () => onMediaUpload.call(),
                ),
              ),
            ],
          )
        : EmptyView(
            type: BlankMessageType.UPLOAD_FILE,
            onPressed: () => onMediaUpload.call(),
          );
  }
}
