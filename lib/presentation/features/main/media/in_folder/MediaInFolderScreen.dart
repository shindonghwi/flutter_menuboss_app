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
    final mediaProvider = ref.read(MediaInFolderListProvider.notifier);
    final rootMediaProvider = ref.read(MediaListProvider.notifier);
    final mediaList = useState<List<ResponseMediaModel>?>(null);
    final folderName = useState(item?.name ?? "");

    void requestMedias() {
      mediaProvider.initPageInfo();
      mediaProvider.requestGetMedias(mediaId: item!.mediaId);
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        requestMedias();
      });
      return () {
        mediaProvider.init();
      };
    }, []);  // 의존성 배열을 빈 배열로 설정하여 이 useEffect가 한 번만 실행되도록 합니다.

    useEffect(() {
      // mediaState가 변경될 때마다 실행될 로직
      WidgetsBinding.instance.addPostFrameCallback((_) {
        mediaState.when(
          success: (event) {
            mediaList.value = event.value;
            final count = mediaList.value?.length ?? 0;
            final size = mediaList.value?.map((e) => e.property?.size ?? 0).reduce(
                  (value, element) => value + element,
            );
            debugPrint("count: $count, size: $size");
            rootMediaProvider.updateLumpFolderCountAndSize(item!.mediaId, count, size ?? 0, isUiUpdate: true);
          },
          failure: (event) => Toast.showError(context, event.errorMessage),
        );
      });
      return null;
    }, [mediaState]);

    debugPrint("MediaInFolderScreen build ${mediaState}");

    void doMediaUploadAction() {
      final uploadProgressProvider = ref.read(mediaUploadProgressProvider.notifier);

      FilePickerUtil.pickFile(
        onImageSelected: (XFile xFile) async {
          final controller = await uploadProgressProvider.uploadStart(xFile.path, isVideo: false);
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
        },
        onVideoSelected: (XFile xFile) async {
          final controller = await uploadProgressProvider.uploadStart(xFile.path, isVideo: true);
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
                onClicked: (name) {
                  folderName.value = name;
                  rootMediaProvider.renameItem(item?.mediaId ?? "", name);
                },
              ),
            );
          }),
          Pair("assets/imgs/icon_trash.svg", () {
            CommonPopup.showPopup(
              context,
              child: PopupDelete(onClicked: () async {
                final isRemoved = await rootMediaProvider.removeItem([item?.mediaId ?? ""]);
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
                  FailView(onPressed: () => mediaProvider.requestGetMedias(mediaId: item!.mediaId))
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
    final mediaProvider = ref.read(MediaInFolderListProvider.notifier);
    final rootMediaProvider = ref.read(MediaListProvider.notifier);

    return items.isNotEmpty
        ? Stack(
            children: [
              ListView.builder(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                physics: const BouncingScrollPhysics(),
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
                          mediaProvider.renameItem(item.mediaId, newName);
                        }
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    },
                    child: MediaItem(
                      item: item,
                      onRemove: () async {
                        final isRemoved = await mediaProvider.removeItem([item.mediaId]);
                        if (isRemoved) {
                          rootMediaProvider.updateFolderCountAndSize(
                            folderId,
                            item.property?.size ?? 0,
                            isIncrement: false,
                            isUiUpdate: true,
                          );
                        }
                      },
                      onRename: (newName) {
                        mediaProvider.renameItem(item.mediaId, newName);
                      },
                    ),
                  );
                },
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
