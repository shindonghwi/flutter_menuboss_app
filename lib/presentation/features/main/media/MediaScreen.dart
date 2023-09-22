import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
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
import 'widget/MediaItem.dart';

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
              mediaProvider.init();
            },
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [mediaState]);

    void goToUploadGallery() {
      FilePickerUtil.pickFile(
        onImageSelected: (XFile xFile) {
          Toast.showSuccess(context, "이미지 업로드 진행해야함");
        },
        onVideoSelected: (XFile xFile) {
          Toast.showSuccess(context, "비디오 업로드 진행해야함");
        },
        notAvailableFile: () {
          Toast.showSuccess(context, "업로드 불가능한 파일");
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
                () => goToUploadGallery(),
              ),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                if (mediaState is Failure)
                  FailView(onPressed: () => mediaProvider.requestGetMedias())
                else if (mediaList.value != null)
                  _MediaContentList(
                    items: mediaList.value!,
                    onMediaUpload: () => goToUploadGallery(),
                  )
                else if (mediaState is Success<List<ResponseMediaModel>>)
                  _MediaContentList(
                    items: mediaState.value,
                    onMediaUpload: () => goToUploadGallery(),
                  ),
                if (mediaState is Loading) const LoadingView(),
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
                              mediaProvider.removeItem([item.mediaId ?? ""]);
                            },
                            onRename: (newName) {
                              mediaProvider.renameItem(item.mediaId ?? "", newName);
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
