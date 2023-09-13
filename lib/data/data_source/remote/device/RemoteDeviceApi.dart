import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/ApiListResponse.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../../../models/device/ResponseDeviceModel.dart';
import '../BaseApiUtil.dart';
import '../Service.dart';

class RemoteDeviceApi {
  RemoteDeviceApi();

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  /// 스크린 목록 조회
  Future<ApiListResponse<List<ResponseDeviceModel>>> getDevices() async {
    final response = await Service.getApi(
      type: ServiceType.Device,
      endPoint: null,
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
          return List<ResponseDeviceModel>.from(
            json.map((item) => ResponseDeviceModel.fromJson(item as Map<String, dynamic>)),
          );
        },
      );
    }
  }
}
