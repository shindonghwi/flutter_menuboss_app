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
  Future<ApiResponse<ResponseFileModel>> postMediaImageUpload(String filePath, {String? folderId}) async {
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

    final response = await Service.postUploadApi(
      type: ServiceType.File,
      endPoint: "upload/media/images",
      file: file,
      jsonBody: {
        if (folderId != null) "folderId": folderId,
      },
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) => ResponseFileModel.fromJson(json),
      );
    }
  }

  /// 미디어 비디오 등록
  Future<ApiResponse<ResponseFileModel>> postMediaVideoUpload(String filePath, {String? folderId}) async {
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

    final response = await Service.postUploadApi(
      type: ServiceType.File,
      endPoint: "upload/media/videos",
      file: file,
      jsonBody: {
        if (folderId != null) "folderId": folderId,
      },
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) => ResponseFileModel.fromJson(json),
      );
    }
  }

  /// 프로필 이미지 등록
  Future<ApiResponse<ResponseFileModel>> postProfileImageUpload(String filePath) async {
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

    final response = await Service.postUploadApi(
      type: ServiceType.File,
      endPoint: "upload/profile/images",
      file: file,
      jsonBody: {},
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) => ResponseFileModel.fromJson(json),
      );
    }
  }
}
