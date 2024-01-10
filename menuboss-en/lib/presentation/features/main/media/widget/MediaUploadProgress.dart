import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/file/ResponseFileModel.dart';
import 'package:menuboss/domain/usecases/remote/file/PostUploadMediaImageUseCase.dart';
import 'package:menuboss/domain/usecases/remote/file/PostUploadMediaVideoUseCase.dart';
import 'package:menuboss/presentation/features/main/media/provider/MediaListProvider.dart';
import 'package:menuboss_common/components/loader/LoadLottie.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/Strings.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

import '../provider/MediaUploadProvider.dart';

class MediaUploadProgress extends HookConsumerWidget {
  const MediaUploadProgress({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaUploadState = ref.watch(mediaUploadProgressProvider);
    final mediaUploadProvider = ref.read(mediaUploadProgressProvider.notifier);

    return mediaUploadState.isUploading != UploadState.IDLE
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(
                                width: 1,
                                color: getColorScheme(context).colorGray200,
                              ),
                              color: getColorScheme(context).colorGray100,
                            ),
                            child: mediaUploadProvider.thumbnailFile != null
                                ? Image.file(
                                    mediaUploadState.thumbnailFile!,
                                    width: 32,
                                    height: 32,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 32,
                                    height: 32,
                                    color: getColorScheme(context).colorGray100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: LoadSvg(
                                        path: "assets/imgs/image_logo_text.svg",
                                        width: 20,
                                        height: 10,
                                        color: getColorScheme(context).colorGray400,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mediaUploadState.currentFile!.path.split('/').last,
                                  style: getTextTheme(context).b3m.copyWith(
                                        color: getColorScheme(context).colorGray900,
                                      ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      mediaUploadState.currentProgressByte,
                                      style: getTextTheme(context).c2m.copyWith(
                                            color: mediaUploadState.isUploading == UploadState.SUCCESS ||
                                                    mediaUploadState.isUploading == UploadState.UPLOADING
                                                ? getColorScheme(context).colorGreen500
                                                : mediaUploadState.isUploading == UploadState.FAIL
                                                    ? getColorScheme(context).colorRed500
                                                    : getColorScheme(context).colorGray500,
                                          ),
                                    ),
                                    Text(
                                      " / ${StringUtil.formatBytesToMegabytes(mediaUploadState.getFileSize())}",
                                      style: getTextTheme(context).c2m.copyWith(
                                            color: mediaUploadState.isUploading == UploadState.SUCCESS ||
                                                    mediaUploadState.isUploading == UploadState.UPLOADING
                                                ? getColorScheme(context).colorGreen500
                                                : mediaUploadState.isUploading == UploadState.FAIL
                                                    ? getColorScheme(context).colorRed500
                                                    : getColorScheme(context).colorGray500,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (mediaUploadState.isUploading == UploadState.SUCCESS) const _SuffixSuccess(),
                        if (mediaUploadState.isUploading == UploadState.FAIL) const _SuffixFail(),
                        if (mediaUploadState.isUploading == UploadState.UPLOADING) const _SuffixLoading()
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: LinearProgressIndicator(
                          minHeight: 4,
                          value: mediaUploadState.uploadProgress,
                          backgroundColor: getColorScheme(context).colorGray100,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            mediaUploadState.isUploading == UploadState.SUCCESS ||
                                    mediaUploadState.isUploading == UploadState.UPLOADING
                                ? getColorScheme(context).colorGreen500
                                : mediaUploadState.isUploading == UploadState.FAIL
                                    ? getColorScheme(context).colorRed500
                                    : getColorScheme(context).colorGray500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: getColorScheme(context).colorGray100,
              )
            ],
          )
        : Container();
  }
}

class _SuffixSuccess extends HookConsumerWidget {
  const _SuffixSuccess({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaUploadProvider = ref.read(mediaUploadProgressProvider.notifier);

    return Row(
      children: [
        LoadSvg(
          path: "assets/imgs/icon_check_filled.svg",
          width: 20,
          height: 20,
          color: getColorScheme(context).colorGreen500,
        ),
        Clickable(
          onPressed: () => mediaUploadProvider.uploadIdle(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: LoadSvg(
              path: "assets/imgs/icon_close_line.svg",
              width: 20,
              height: 20,
              color: getColorScheme(context).colorGray500,
            ),
          ),
        )
      ],
    );
  }
}

class _SuffixFail extends HookConsumerWidget {
  const _SuffixFail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadProgressProvider = ref.read(mediaUploadProgressProvider.notifier);
    final mediaManager = ref.read(mediaListProvider.notifier);

    /**
     * @feature: 이미지 또는 비디오를 업로드 한 뒤 응답처리
     * @author: 2023/11/16 8:02 PM donghwishin
     */
    void responseLogic(ApiResponse<ResponseFileModel> response) {
      if (response.status == 200) {
        mediaManager.initPageInfo();
        mediaManager.requestGetMedias();
        uploadProgressProvider.uploadSuccess();
      } else {
        Toast.showError(context, response.message);
        uploadProgressProvider.uploadFail();
      }
    }

    return Row(
      children: [
        Clickable(
          onPressed: () async {
            final controller = await uploadProgressProvider.uploadStart(
              uploadProgressProvider.currentFile!.path,
              isVideo: uploadProgressProvider.isLastUploadVideo,
              onNetworkError: () => Toast.showError(
                context,
                Strings.of(context).messageNetworkRequired,
              ),
            );
            if (controller != null) {
              if (uploadProgressProvider.isLastUploadVideo) {
                GetIt.instance<PostUploadMediaVideoUseCase>()
                    .call(uploadProgressProvider.currentFile!.path, streamController: controller)
                    .then((response) {
                  responseLogic(response);
                });
              } else {
                GetIt.instance<PostUploadMediaImageUseCase>()
                    .call(uploadProgressProvider.currentFile!.path, streamController: controller)
                    .then((response) {
                  responseLogic(response);
                });
              }
            }
          },
          child: LoadSvg(
            path: "assets/imgs/icon_refresh.svg",
            width: 20,
            height: 20,
            color: getColorScheme(context).colorGray500,
          ),
        ),
        Clickable(
          onPressed: () => uploadProgressProvider.uploadIdle(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: LoadSvg(
              path: "assets/imgs/icon_close_line.svg",
              width: 20,
              height: 20,
              color: getColorScheme(context).colorGray500,
            ),
          ),
        )
      ],
    );
  }
}

class _SuffixLoading extends HookWidget {
  const _SuffixLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Padding(
          padding: EdgeInsets.all(12.0),
          child: LoadLottie(
            path: 'assets/motions/loading_progress.json',
            width: 20,
            height: 20,
            fit: BoxFit.fill,
          ),
        )
      ],
    );
  }
}
