import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../../../models/file/ResponseFileModel.dart';
import '../BaseApiUtil.dart';
import '../Service.dart';

class RemoteFileApi {
  RemoteFileApi();

  static final allowedExtensionsImage = ['jpg', 'jpeg', 'png'];
  static final allowedExtensionsVideo = ['mp4', 'avi', 'mov', 'flv'];

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  /// 미디어 이미지 등록
  Future<ApiResponse<ResponseFileModel>> postMediaImageUpload(
    String filePath, {
    String? folderId,
    StreamController<double>? streamController,
  }) async {
    final file = File(filePath);

    if (!file.existsSync()) {
      return ApiResponse(
        status: 404,
        message: _getAppLocalization.get().message_file_not_found_404,
        data: null,
      );
    } else if (!allowedExtensionsImage.contains(file.path.split('.').last)) {
      return ApiResponse(
        status: 400,
        message: _getAppLocalization.get().message_file_not_allow_404,
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
        message: _getAppLocalization.get().message_file_not_found_404,
        data: null,
      );
    } else if (!allowedExtensionsVideo.contains(file.path.split('.').last)) {
      return ApiResponse(
        status: 400,
        message: _getAppLocalization.get().message_file_not_allow_404,
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
        message: _getAppLocalization.get().message_file_not_found_404,
        data: null,
      );
    } else if (!allowedExtensionsImage.contains(file.path.split('.').last)) {
      return ApiResponse(
        status: 400,
        message: _getAppLocalization.get().message_file_not_allow_404,
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
