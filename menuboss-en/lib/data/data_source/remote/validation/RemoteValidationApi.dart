import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/domain/models/auth/LoginPlatform.dart';

import '../BaseApiUtil.dart';
import '../Service.dart';

class RemoteValidationApi {
  RemoteValidationApi();

  /// 소셜 로그인 체크
  Future<ApiResponse<void>> postSocialVerify(LoginPlatform platform, String accessToken) async {
    try {
      final response = await Service.postApi(
        type: ServiceType.Validation,
        endPoint: "social/login",
        jsonBody: {
          "type": platform.name,
          "accessToken": accessToken,
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
          (json) => {},
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }
}
