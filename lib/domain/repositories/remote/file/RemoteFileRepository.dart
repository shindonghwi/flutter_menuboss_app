import 'dart:async';

import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/file/ResponseFileModel.dart';

import '../../../../data/models/device/RequestDeviceApplyContents.dart';
import '../../../../data/models/device/ResponseDeviceModel.dart';

abstract class RemoteFileRepository {

  /// 미디어 이미지 등록
  Future<ApiResponse<ResponseFileModel>> postMediaImageUpload(String filePath, {String? folderId});

  /// 미디어 비디오 등록
  Future<ApiResponse<ResponseFileModel>> postMediaVideoUpload(String filePath, {String? folderId});

  /// 프로필 이미지 등록
  Future<ApiResponse<ResponseFileModel>> postProfileImageUpload(String filePath);

}
