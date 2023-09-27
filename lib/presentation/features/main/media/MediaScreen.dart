import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/domain/usecases/remote/file/PostUploadMediaImageUseCase.dart';
import 'package:menuboss/domain/usecases/remote/file/PostUploadMediaVideoUseCase.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleIcon.dart';
import 'package:menuboss/presentation/components/button/FilterButton.dart';
import 'package:menuboss/presentation/components/button/FloatingButton.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/ClickableScale.dart';
import 'package:menuboss/presentation/components/view_state/EmptyView.dart';
import 'package:menuboss/presentation/components/view_state/FailView.dart';
import 'package:menuboss/presentation/features/main/media/provider/MediaListProvider.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/FilePickerUtil.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

import '../../../components/view_state/LoadingView.dart';
import 'provider/MediaUploadProvider.dart';
import 'widget/MediaItem.dart';
import 'widget/MediaUploadProgress.dart';

class MediaScreen extends HookConsumerWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaState = ref.watch(MediaListProvider);
    final mediaProvider = ref.read(MediaListProvider.notifier);
    final mediaList = useState<List<ResponseMediaModel>?>(null);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        mediaProvider.requestGetMedias();
      });
      return null;
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

    void doMediaUploadAction() {
      final uploadProgressProvider = ref.read(mediaUploadProgressProvider.notifier);

      FilePickerUtil.pickFile(
        onImageSelected: (XFile xFile) async {
          final controller = await uploadProgressProvider.uploadStart(xFile.path, isVideo: false);
          GetIt.instance<PostUploadMediaImageUseCase>().call(xFile.path, streamController: controller).then((response) {
            if (response.status == 200) {
              mediaProvider.initPageInfo();
              mediaProvider.requestGetMedias();
              uploadProgressProvider.uploadSuccess();
            } else {
              Toast.showError(context, response.message);
              uploadProgressProvider.uploadFail();
            }
          });
        },
        onVideoSelected: (XFile xFile) async {
          final controller = await uploadProgressProvider.uploadStart(xFile.path, isVideo: true);
          GetIt.instance<PostUploadMediaVideoUseCase>().call(xFile.path, streamController: controller).then((response) {
            if (response.status == 200) {
              mediaProvider.initPageInfo();
              mediaProvider.requestGetMedias();
              uploadProgressProvider.uploadSuccess();
            } else {
              Toast.showError(context, response.message);
              uploadProgressProvider.uploadFail();
            }
          });
        },
        notAvailableFile: () {
          Toast.showSuccess(context, getAppLocalizations(context).message_file_not_allow_404);
        },
        onError: (message) {
          Toast.showError(context, message);
        },
      );
    }

    return SafeArea(
      child: Column(
        children: [
          TopBarIconTitleIcon(
            leadingIsShow: false,
            content: getAppLocalizations(context).main_navigation_menu_media,
            suffixIcons: [
              Pair(
                "assets/imgs/icon_new_folder.svg",
                () {
                  mediaProvider.createFolder();
                },
              ),
              Pair(
                "assets/imgs/icon_check_round.svg",
                () {
                  Navigator.push(
                    context,
                    nextSlideHorizontalScreen(
                      RoutingScreen.SelectMediaFile.route,
                    ),
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                const MediaUploadProgress(),
                Expanded(
                  child: Stack(
                    children: [
                      if (mediaState is Failure && mediaList.value == null)
                        FailView(onPressed: () => mediaProvider.requestGetMedias())
                      // else if (mediaList.value != null)
                      //   _MediaContentList(
                      //     items: mediaList.value!,
                      //     onMediaUpload: () => doMediaUploadAction(),
                      //   )
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
    final mediaProvider = ref.read(MediaListProvider.notifier);
    final scrollController = useScrollController(keepScrollOffset: true);

    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent * 0.7 <= scrollController.position.pixels) {
          mediaProvider.requestGetMedias();
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
                      onSelected: (type, text) {
                        mediaProvider.changeFilterType(type);
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
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
                                  mediaProvider.renameItem(item.mediaId ?? "", newName);
                                }
                              } catch (e) {
                                debugPrint(e.toString());
                              }
                            }
                          },
                          child: MediaItem(
                            item: item,
                            onRemove: () {
                              mediaProvider.removeItem([item.mediaId]);
                            },
                            onRename: (newName) {
                              mediaProvider.renameItem(item.mediaId, newName);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(bottom: 32, right: 24),
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
