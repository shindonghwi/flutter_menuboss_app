import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';

import '../../../models/file/ResponseFileModel.dart';
import '../BaseApiUtil.dart';
import '../Service.dart';

class RemoteFileApi {
  RemoteFileApi();

  static final allowedExtensionsImage = ['jpg', 'jpeg', 'png'];
  static final allowedExtensionsVideo = ['mp4', 'avi', 'mov', 'flv'];

  /// 미디어 이미지 등록
  Future<ApiResponse<ResponseFileModel>> postMediaImageUpload(
    String filePath, {
    String? folderId,
    StreamController<double>? streamController,
  }) async {
    debugPrint("postMediaImageUpload : $folderId");
    debugPrint("postMediaImageUpload : $filePath // extension : ${filePath.split('.').last}");
    final file = File(filePath);

    if (!file.existsSync()) {
      return ApiResponse(
        status: 404,
        message: "파일을 찾을 수 없습니다\n잠시후에 다시 시도해주세요",
        data: null,
      );
    } else if (!allowedExtensionsImage.contains(file.path.split('.').last) &&
        !allowedExtensionsVideo.contains(file.path.split('.').last)) {
      return ApiResponse(
        status: 400,
        message: "허용되지 않는 파일 확장자입니다.\n다시 시도해주세요",
        data: null,
      );
    }

    try {
      final response = await Service.postUploadApi(
        type: ServiceType.File,
        endPoint: "upload/media/images",
        file: file,
        jsonBody: {
          if (folderId != null) "folderId": folderId,
        },
        uploadProgressController: streamController,
      );

      final errorResponse = BaseApiUtil.isErrorStatusCode(response);
      if (errorResponse != null) {
        return BaseApiUtil.errorResponse(
          status: errorResponse.status,
          message: errorResponse.message,
        );
      } else {
        return ApiResponse.fromJson(
          jsonDecode(response.body),
          (json) => ResponseFileModel.fromJson(json),
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// 미디어 비디오 등록
  Future<ApiResponse<ResponseFileModel>> postMediaVideoUpload(
    String filePath, {
    String? folderId,
    StreamController<double>? streamController,
  }) async {
    final file = File(filePath);
    if (!file.existsSync()) {
      return ApiResponse(
        status: 404,
        message: "파일을 찾을 수 없습니다\n잠시후에 다시 시도해주세요",
        data: null,
      );
    } else if (!allowedExtensionsVideo.contains(file.path.split('.').last)) {
      return ApiResponse(
        status: 400,
        message: "허용되지 않는 파일 확장자입니다.\n다시 시도해주세요",
        data: null,
      );
    }

    try {
      final response = await Service.postUploadApi(
        type: ServiceType.File,
        endPoint: "upload/media/videos",
        file: file,
        jsonBody: {
          if (folderId != null) "folderId": folderId,
        },
        uploadProgressController: streamController,
      );

      final errorResponse = BaseApiUtil.isErrorStatusCode(response);
      if (errorResponse != null) {
        return BaseApiUtil.errorResponse(
          status: errorResponse.status,
          message: errorResponse.message,
        );
      } else {
        return ApiResponse.fromJson(
          jsonDecode(response.body),
          (json) => ResponseFileModel.fromJson(json),
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// 프로필 이미지 등록
  Future<ApiResponse<ResponseFileModel>> postProfileImageUpload(
    String filePath, {
    StreamController<double>? streamController,
  }) async {
    final file = File(filePath);

    if (!file.existsSync()) {
      return ApiResponse(
        status: 404,
        message: "파일을 찾을 수 없습니다\n잠시후에 다시 시도해주세요",
        data: null,
      );
    } else if (!allowedExtensionsImage.contains(file.path.split('.').last)) {
      return ApiResponse(
        status: 400,
        message: "허용되지 않는 파일 확장자입니다.\n다시 시도해주세요",
        data: null,
      );
    }

    try {
      final response = await Service.postUploadApi(
        type: ServiceType.File,
        endPoint: "upload/profile/images",
        file: file,
        jsonBody: {},
        uploadProgressController: streamController,
      );

      final errorResponse = BaseApiUtil.isErrorStatusCode(response);
      if (errorResponse != null) {
        return BaseApiUtil.errorResponse(
          status: errorResponse.status,
          message: errorResponse.message,
        );
      } else {
        return ApiResponse.fromJson(
          jsonDecode(response.body),
          (json) => ResponseFileModel.fromJson(json),
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }
}
