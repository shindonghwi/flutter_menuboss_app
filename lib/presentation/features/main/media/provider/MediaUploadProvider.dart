import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/data_source/remote/Service.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

final mediaUploadProgressProvider = ChangeNotifierProvider((ref) => MediaUploadProgressNotifier());

enum UploadState { IDLE, UPLOADING, SUCCESS, FAIL }

class MediaUploadProgressNotifier extends ChangeNotifier {
  UploadState isUploading = UploadState.IDLE;
  String currentProgressByte = "";
  double uploadProgress = 0.0;
  Timer? _timer;

  StreamController<double>? uploadProgressController;

  File? currentFile;
  File? thumbnailFile;
  bool isLastUploadVideo = false;

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

      debugPrint("uploadProgressController : $isUploading $currentProgressByte / $formattedTotalSize");

      notifyListeners();
    });
  }

  Future<StreamController<double>?> uploadStart(String filePath, {bool isVideo = false, VoidCallback? onNetworkError}) async {

    if (!await Service.isNetworkAvailable()) {
      onNetworkError?.call();
      return Future(() => null);
    }

    isLastUploadVideo = isVideo;
    uploadIdle();

    if (isVideo == true) {
      String? thumbnailFilePath = await generateThumbnail(filePath);
      currentFile = File(filePath);
      thumbnailFile = thumbnailFilePath == null ? null : File(thumbnailFilePath);
    }else{
      currentFile = File(filePath);
      thumbnailFile = File(filePath);
    }

    uploadProgressController?.close();
    uploadProgressController = StreamController<double>.broadcast();
    uploadStatusChange(UploadState.UPLOADING);
    uploadProgressController?.stream.listen((event) {
      setSmoothUploadProgress(event);
    });
    notifyListeners();
    return uploadProgressController!;
  }

  void uploadIdle() {
    currentProgressByte =StringUtil.formatBytesToMegabytes(0);
    uploadProgress = 0.0;
    _timer?.cancel();
    isUploading = UploadState.IDLE;
    notifyListeners();
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

  Future<String?> generateThumbnail(String videoPath) async {
    try{
      return await VideoThumbnail.thumbnailFile(
        video: videoPath,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.PNG,
        quality: 25,
      );
    }catch(e){
      debugPrint("generateThumbnail error : $e");
    }

    return Future(() => null);
  }

  @override
  void dispose() {
    _timer?.cancel();
    uploadProgressController?.close();
    super.dispose();
  }
}
