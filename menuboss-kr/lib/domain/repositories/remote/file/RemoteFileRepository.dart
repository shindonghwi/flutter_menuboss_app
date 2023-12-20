import 'dart:async';

import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/file/ResponseFileModel.dart';

abstract class RemoteFileRepository {
  /// 미디어 이미지 등록
  Future<ApiResponse<ResponseFileModel>> postMediaImageUpload(
    String filePath, {
    String? folderId,
    StreamController<double>? streamController,
  });

  /// 미디어 비디오 등록
  Future<ApiResponse<ResponseFileModel>> postMediaVideoUpload(
    String filePath, {
    String? folderId,
    StreamController<double>? streamController,
  });

  /// 프로필 이미지 등록
  Future<ApiResponse<ResponseFileModel>> postProfileImageUpload(
    String filePath, {
    StreamController<double>? streamController,
  });
}
