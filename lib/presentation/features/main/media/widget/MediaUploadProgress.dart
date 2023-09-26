import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
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
                          children: [
                            Text(
                              mediaUploadState.currentFile!.path.split('/').last,
                              style: getTextTheme(context).b3sb.copyWith(
                                    color: getColorScheme(context).colorGray900,
                                  ),
                            ),
                            Text(
                              "${mediaUploadState.currentProgressByte} / ${StringUtil.formatBytesToMegabytes(mediaUploadState.getFileSize())}",
                              style: getTextTheme(context).b3sb.copyWith(
                                    color: getColorScheme(context).colorGray900,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                LinearProgressIndicator(
                  minHeight: 2,
                  value: mediaUploadState.uploadProgress,
                  backgroundColor: getColorScheme(context).colorGray100,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    getColorScheme(context).colorGray500,
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
