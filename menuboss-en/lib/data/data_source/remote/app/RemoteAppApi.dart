import 'dart:convert';

import 'package:menuboss/data/models/base/ApiResponse.dart';
import '../../../models/app/ResponseAppCheckUpModel.dart';
import '../BaseApiUtil.dart';
import '../Service.dart';

class RemoteAppApi {
  RemoteAppApi();

  /// @feature: 앱 버전 체크
  /// @author: 2024/03/08 9:42 PM donghwishin
  Future<ApiResponse<ResponseAppCheckUpModel>> checkApp() async {
    try {
      final response = await Service.getApi(
        type: ServiceType.App,
        endPoint: 'checkup',
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
          (json) => ResponseAppCheckUpModel.fromJson(json),
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }
}
