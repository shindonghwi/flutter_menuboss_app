import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/me/RequestMeJoinModel.dart';
import 'package:menuboss/data/models/me/ResponseMeAuthorization.dart';
import 'package:menuboss/data/models/me/ResponseMeUpdateProfile.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import '../../../models/me/ResponseMeInfoModel.dart';
import '../BaseApiUtil.dart';
import '../Service.dart';

class RemoteMeApi {
  RemoteMeApi();

  /// 내 정보 요청
  Future<ApiResponse<ResponseMeInfoModel>> getMe() async {
    try {
      final response = await Service.getApi(
        type: ServiceType.Me,
        endPoint: null,
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
          (json) => ResponseMeInfoModel.fromJson(json),
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// Owner 이름 수정
  Future<ApiResponse<void>> patchName(String name) async {
    try {
      final response = await Service.patchApi(
        type: ServiceType.Me,
        endPoint: "name",
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

  /// 이메일 회원가입
  Future<ApiResponse<ResponseMeAuthorization>> postJoin(RequestMeJoinModel model) async {
    try {
      final response = await Service.postApi(
        type: ServiceType.Me,
        endPoint: "join",
        jsonBody: model.toJson(),
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
          (json) => ResponseMeAuthorization.fromJson(json),
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// 계정 삭제
  Future<ApiResponse<void>> postMeLeave(String? reason) async {
    try {
      final response = await Service.postApi(
        type: ServiceType.Me,
        endPoint: "leave",
        jsonBody: {if (!CollectionUtil.isNullEmptyFromString(reason)) "reason": reason},
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

  /// 프로필 이미지 업데이트
  Future<ApiResponse<ResponseMeUpdateProfile>> patchProfileImage(int imageId) async {
    try {
      final response = await Service.patchApi(
        type: ServiceType.Me,
        endPoint: "profile/image",
        jsonBody: {"imageId": imageId},
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
          (json) => ResponseMeUpdateProfile.fromJson(json),
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }
}
