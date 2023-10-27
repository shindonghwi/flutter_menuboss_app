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
import 'package:menuboss/presentation/components/button/FloatingButton.dart';
import 'package:menuboss/presentation/components/popup/CommonPopup.dart';
import 'package:menuboss/presentation/components/popup/PopupDelete.dart';
import 'package:menuboss/presentation/components/popup/PopupRename.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/utils/ClickableScale.dart';
import 'package:menuboss/presentation/components/view_state/EmptyView.dart';
import 'package:menuboss/presentation/components/view_state/FailView.dart';
import 'package:menuboss/presentation/components/view_state/LoadingView.dart';
import 'package:menuboss/presentation/features/main/media/provider/MediaListProvider.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/FilePickerUtil.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

import '../provider/MediaUploadProvider.dart';
import '../widget/MediaItem.dart';
import '../widget/MediaUploadProgress.dart';
import 'provider/MediaInFolderListProvider.dart';

class MediaInFolderScreen extends HookConsumerWidget {
  final ResponseMediaModel? item;

  const MediaInFolderScreen({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaState = ref.watch(MediaInFolderListProvider);
    final mediaManager = ref.read(MediaInFolderListProvider.notifier);
    final rootMediaManager = ref.read(mediaListProvider.notifier);
    final mediaList = useState<List<ResponseMediaModel>?>(null);
    final folderName = useState(item?.name ?? "");

    void requestMedias() {
      mediaManager.initPageInfo();
      mediaManager.requestGetMedias(mediaId: item!.mediaId);
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        requestMedias();
      });
      return () {
        mediaList.value?.clear();
        mediaManager.init();
      };
    }, []); // 의존성 배열을 빈 배열로 설정하여 이 useEffect가 한 번만 실행되도록 합니다.

    useEffect(() {
      // mediaState가 변경될 때마다 실행될 로직
      WidgetsBinding.instance.addPostFrameCallback((_) {
        mediaState.when(
          success: (event) {
            mediaList.value = event.value;
            final count = mediaList.value?.length ?? 0;
            final sizeList = mediaList.value?.map((e) => e.property?.size ?? 0);
            final size = sizeList!.isEmpty
                ? 0
                : sizeList.reduce(
                    (value, element) => value + element,
                  );
            debugPrint("count: $count, size: $size");
            rootMediaManager.updateLumpFolderCountAndSize(item!.mediaId, count, size ?? 0, isUiUpdate: true);
          },
          failure: (event) => Toast.showError(context, event.errorMessage),
        );
      });
      return null;
    }, [mediaState]);

    void doMediaUploadAction() {
      final uploadProgressProvider = ref.read(mediaUploadProgressProvider.notifier);

      FilePickerUtil.pickFile(
        onImageSelected: (XFile xFile) async {
          final controller = await uploadProgressProvider.uploadStart(
            xFile.path,
            isVideo: false,
            onNetworkError: () {
              Toast.showError(context, getAppLocalizations(context).message_network_required);
            },
          );

          if (controller != null) {
            GetIt.instance<PostUploadMediaImageUseCase>()
                .call(
              xFile.path,
              folderId: item!.mediaId,
              streamController: controller,
            )
                .then((response) {
              if (response.status == 200) {
                requestMedias();
                uploadProgressProvider.uploadSuccess();
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
              Toast.showError(context, getAppLocalizations(context).message_network_required);
            },
          );

          if (controller != null) {
            GetIt.instance<PostUploadMediaVideoUseCase>()
                .call(
              xFile.path,
              folderId: item!.mediaId,
              streamController: controller,
            )
                .then((response) {
              if (response.status == 200) {
                requestMedias();
                uploadProgressProvider.uploadSuccess();
              } else {
                Toast.showError(context, response.message);
                uploadProgressProvider.uploadFail();
              }
            });
          }
        },
        notAvailableFile: () {
          Toast.showSuccess(context, getAppLocalizations(context).message_file_not_allow_404);
        },
        onError: (message) {
          Toast.showError(context, message);
        },
      );
    }

    return BaseScaffold(
      appBar: TopBarIconTitleIcon(
        leadingIsShow: true,
        content: folderName.value,
        suffixIcons: [
          Pair("assets/imgs/icon_edit.svg", () {
            CommonPopup.showPopup(
              context,
              child: PopupRename(
                hint: getAppLocalizations(context).popup_rename_media_hint,
                name: folderName.value,
                onClicked: (name) {
                  folderName.value = name;
                  rootMediaManager.renameItem(item?.mediaId ?? "", name);
                },
              ),
            );
          }),
          Pair("assets/imgs/icon_trash.svg", () {
            CommonPopup.showPopup(
              context,
              child: PopupDelete(onClicked: () async {
                final isRemoved = await rootMediaManager.removeItem([item?.mediaId ?? ""]);
                if (isRemoved) {
                  Navigator.of(context).pop();
                }
              }),
            );
          }),
        ],
      ),
      body: Column(
        children: [
          const MediaUploadProgress(),
          Expanded(
            child: Stack(
              children: [
                if (mediaState is Failure && mediaList.value == null)
                  FailView(onPressed: () => mediaManager.requestGetMedias(mediaId: item!.mediaId))
                else if (mediaList.value != null)
                  _MediaContentList(
                    folderId: item!.mediaId,
                    items: mediaList.value!,
                    onMediaUpload: () => doMediaUploadAction(),
                  )
                else if (mediaState is Success<List<ResponseMediaModel>>)
                  _MediaContentList(
                    folderId: item!.mediaId,
                    items: mediaState.value,
                    onMediaUpload: () => doMediaUploadAction(),
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
  final String folderId;
  final List<ResponseMediaModel> items;
  final VoidCallback onMediaUpload;

  const _MediaContentList({
    super.key,
    required this.items,
    required this.onMediaUpload,
    required this.folderId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaManager = ref.read(MediaInFolderListProvider.notifier);
    final rootMediaManager = ref.read(mediaListProvider.notifier);

    return items.isNotEmpty
        ? Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  mediaManager.initPageInfo();
                  mediaManager.requestGetMedias(mediaId: folderId, delayed: 300);
                },
                color: getColorScheme(context).colorPrimary500,
                backgroundColor: getColorScheme(context).white,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ClickableScale(
                      onPressed: () async {
                        try {
                          final newName = await Navigator.push(
                            context,
                            nextSlideHorizontalScreen(
                              RoutingScreen.MediaInfo.route,
                              parameter: item,
                            ),
                          );

                          if (!CollectionUtil.isNullEmptyFromString(newName)) {
                            mediaManager.renameItem(item.mediaId, newName);
                          }
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                      child: MediaItem(
                        item: item,
                        onRemove: () async {
                          final isRemoved = await mediaManager.removeItem([item.mediaId]);
                          if (isRemoved) {
                            rootMediaManager.updateFolderCountAndSize(
                              folderId,
                              item.property?.size ?? 0,
                              isIncrement: false,
                              isUiUpdate: true,
                            );
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
