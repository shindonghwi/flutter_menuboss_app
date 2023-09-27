import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

import '../provider/MediaUploadProvider.dart';

class MediaUploadProgress extends HookConsumerWidget {
  const MediaUploadProgress({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaUploadState = ref.watch(mediaUploadProgressProvider);

    return mediaUploadState.isUploading != UploadState.IDLE
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.file(
                        mediaUploadState.currentFile!,
                        width: 32,
                        height: 32,
                        fit: BoxFit.cover,
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
                              style: getTextTheme(context).b3sb.copyWith(
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
                    if (mediaUploadState.isUploading == UploadState.FAIL) const _SuffixFail()
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
          )
        : Container();
  }
}

class _SuffixSuccess extends StatelessWidget {
  const _SuffixSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/imgs/icon_check_filled.svg",
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(
            getColorScheme(context).colorGreen500,
            BlendMode.srcIn,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            "assets/imgs/icon_close_line.svg",
            width: 28,
            height: 28,
            colorFilter: ColorFilter.mode(
              getColorScheme(context).colorGray500,
              BlendMode.srcIn,
            ),
          ),
        )
      ],
    );
  }
}

class _SuffixFail extends StatelessWidget {
  const _SuffixFail({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/imgs/icon_refresh.svg",
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(
            getColorScheme(context).colorGray500,
            BlendMode.srcIn,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            "assets/imgs/icon_refresh.svg",
            width: 28,
            height: 28,
            colorFilter: ColorFilter.mode(
              getColorScheme(context).colorGray500,
              BlendMode.srcIn,
            ),
          ),
        )
      ],
    );
  }
}
