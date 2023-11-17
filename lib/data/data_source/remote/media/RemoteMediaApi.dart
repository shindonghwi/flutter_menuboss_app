import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/media/ResponseMediaCreate.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../../../models/media/ResponseMediaInfoModel.dart';
import '../BaseApiUtil.dart';
import '../Service.dart';

class RemoteMediaApi {
  RemoteMediaApi();

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  /// 미디어 목록 조회
  Future<ApiListResponse<List<ResponseMediaModel>>> getMedias({
    String q = "",
    int page = 1,
    int size = 10,
    String sort = "name_asc",
    String? mediaId,
  }) async {
    try {
      final response = await Service.getApi(
        type: ServiceType.Media,
        endPoint: null,
        query: "q=$q&page=$page&size=$size&sort=$sort&mediaId=$mediaId",
      );

      final errorResponse = BaseApiUtil.isErrorStatusCode(response);
      if (errorResponse != null) {
        return BaseApiUtil.errorListResponse(
          status: errorResponse.status,
          message: errorResponse.message,
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
    } catch (e) {
      return BaseApiUtil.errorListResponse(
        message: e.toString(),
      );
    }
  }

  /// 미디어 정보 조회
  Future<ApiResponse<ResponseMediaInfoModel>> getMedia(String mediaId) async {
    try {
      final response = await Service.getApi(
        type: ServiceType.Media,
        endPoint: mediaId,
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
          (json) => ResponseMediaInfoModel.fromJson(json),
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// 폴더 생성
  Future<ApiResponse<ResponseMediaCreate>> postCreateMediaFolder() async {
    try {
      final response = await Service.postApi(
        type: ServiceType.Media,
        endPoint: "folder",
        jsonBody: null,
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
          (json) => ResponseMediaCreate.fromJson(json),
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// 미디어 이름 변경
  Future<ApiResponse<void>> patchMediaName(String mediaId, String name) async {
    try {
      final response = await Service.patchApi(
        type: ServiceType.Media,
        endPoint: "$mediaId/name",
        jsonBody: {"name": name},
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
          (json) {},
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// 미디어 파일 이동
  Future<ApiResponse<void>> postMediaMove(List<String> mediaIds, {String? folderId}) async {
    try {
      final response = await Service.postApi(
        type: ServiceType.Media,
        endPoint: "move",
        jsonBody: {
          "mediaIds": mediaIds,
          if (!CollectionUtil.isNullEmptyFromString(folderId)) "folderId": folderId,
        },
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
          (json) {},
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// 미디어 파일 삭제
  Future<ApiResponse<void>> delMedia(List<String> mediaIds) async {
    try {
      final response = await Service.postApi(
        type: ServiceType.Media,
        endPoint: "delete",
        jsonBody: {"mediaIds": mediaIds},
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
          (json) {},
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }
}
