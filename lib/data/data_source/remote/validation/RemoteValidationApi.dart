import 'dart:convert';

import 'package:menuboss/data/models/base/ApiResponse.dart';

import '../BaseApiUtil.dart';
import '../Service.dart';

class RemoteValidationApi {
  RemoteValidationApi();

  /// 소셜 로그인 체크
  Future<ApiResponse<void>> postSocialVerify(String type, String accessToken) async {
    final response = await Service.postApi(
      type: ServiceType.Validation,
      endPoint: "social/login",
      jsonBody: {
        "type": type,
        "accessToken": accessToken,
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
        (json) => {},
      );
    }
  }
}
