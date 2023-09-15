import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/media/ResponseMediaCreate.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../../../models/media/ResponseMediaInfoModel.dart';
import '../BaseApiUtil.dart';
import '../Service.dart';

class RemoteMediaApi {
  RemoteMediaApi();

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  /// 미디어 목록 조회
  Future<ApiListResponse<List<ResponseMediaModel>>> getMedias(
      {String q = "", int page = 1, int size = 10, String sort = "name_asc"}) async {
    final response = await Service.getApi(
      type: ServiceType.Media,
      endPoint: null,
      query: "q=$q&page=$page&size=$size&sort=$sort",
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiListResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        list: null,
        count: 0,
      );
    } else {
      return ApiListResponse.fromJson(
        jsonDecode(response.body),
        (json) {
          return List<ResponseMediaModel>.from(
            json.map((item) => ResponseMediaModel.fromJson(item as Map<String, dynamic>)),
          );
        },
      );
    }
  }

  /// 미디어 정보 조회
  Future<ApiResponse<ResponseMediaInfoModel>> getMedia(String mediaId) async {
    final response = await Service.getApi(
      type: ServiceType.Media,
      endPoint: mediaId,
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
        (json) => ResponseMediaInfoModel.fromJson(json),
      );
    }
  }

  /// 폴더 생성
  Future<ApiResponse<ResponseMediaCreate>> postCreateMediaFolder() async {
    final response = await Service.postApi(
      type: ServiceType.Media,
      endPoint: "folder",
      jsonBody: null,
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
        (json) => ResponseMediaCreate.fromJson(json),
      );
    }
  }

  /// 미디어 이름 변경
  Future<ApiResponse<void>> patchMediaName(String mediaId, String name) async {
    final response = await Service.patchApi(
      type: ServiceType.Media,
      endPoint: "$mediaId/name",
      jsonBody: {"name": name},
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
        (json) {},
      );
    }
  }

  /// 미디어 파일 이동
  Future<ApiResponse<void>> postMediaMove(List<String> mediaIds, {String? folderId}) async {
    final response = await Service.postApi(
      type: ServiceType.Media,
      endPoint: "move",
      jsonBody: {"mediaIds": mediaIds, "folderId": folderId},
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
        (json) {},
      );
    }
  }

  /// 미디어 파일 삭제
  Future<ApiResponse<void>> delMedia(List<String> mediaIds) async {
    final response = await Service.postApi(
      type: ServiceType.Media,
      endPoint: "delete",
      jsonBody: {"mediaIds": mediaIds},
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
        (json) {},
      );
    }
  }
}
