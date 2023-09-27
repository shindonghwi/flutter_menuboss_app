import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

final mediaUploadProgressProvider = ChangeNotifierProvider((ref) => MediaUploadProgressNotifier());

enum UploadState { IDLE, UPLOADING, SUCCESS, FAIL }

class MediaUploadProgressNotifier extends ChangeNotifier {
  UploadState isUploading = UploadState.IDLE;
  String currentProgressByte = "";
  double uploadProgress = 0.0;
  Timer? _timer;

  StreamController<double>? uploadProgressController;
  File? currentFile;

  void setSmoothUploadProgress(double targetProgress) {
    final totalBytes = currentFile!.lengthSync().toDouble();

    const updateInterval = Duration(milliseconds: 50);
    double increment = (targetProgress - uploadProgress) / 10;

    _timer?.cancel();
    _timer = Timer.periodic(updateInterval, (timer) {
      if ((increment > 0 && uploadProgress >= targetProgress) || (increment < 0 && uploadProgress <= targetProgress)) {
        _timer?.cancel();
        uploadProgress = targetProgress;
      } else {
        uploadProgress += increment;
      }

      currentProgressByte = StringUtil.formatBytesToMegabytes((uploadProgress * totalBytes).toInt());
      final formattedTotalSize = StringUtil.formatBytesToMegabytes(totalBytes.toInt());

      debugPrint("uploadProgressController : $currentProgressByte / $formattedTotalSize");

      notifyListeners();
    });
  }

  StreamController<double> uploadStart(String filePath) {
    uploadProgress = 0.0;
    currentFile = File(filePath);

    uploadProgressController = StreamController<double>.broadcast();
    uploadStatusChange(UploadState.UPLOADING);
    uploadProgressController?.stream.listen((event) {
      setSmoothUploadProgress(event);
    });
    notifyListeners();
    return uploadProgressController!;
  }

  void uploadFail() {
    isUploading = UploadState.FAIL;
    _timer?.cancel();
    uploadProgress = 1.0;
    notifyListeners();
  }

  void uploadSuccess() {
    isUploading = UploadState.SUCCESS;
    _timer?.cancel();
    uploadProgress = 1.0;
    notifyListeners();
  }

  void uploadStatusChange(UploadState state) {
    isUploading = state;
  }

  int getFileSize() {
    if (currentFile == null) return 0;
    return currentFile!.lengthSync();
  }

  @override
  void dispose() {
    _timer?.cancel();
    uploadProgressController?.close();
    super.dispose();
  }
}
