import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/ApiListResponse.dart';
import 'package:menuboss/data/models/ApiResponse.dart';
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

  /// 스크린 등록
  Future<ApiResponse<void>> postDevice(String code) async {
    final response = await Service.postApi(
      type: ServiceType.Device,
      endPoint: "connect/$code",
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
        (json) {},
      );
    }
  }

  /// 스크린 삭제
  Future<ApiResponse<void>> delDevice(int screenId) async {
    final response = await Service.deleteApi(
      type: ServiceType.Device,
      endPoint: "$screenId",
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
        (json) {},
      );
    }
  }

  /// 스크린 이름 변경
  Future<ApiResponse<void>> patchDeviceName(int screenId, String name) async {
    final response = await Service.patchApi(
      type: ServiceType.Device,
      endPoint: "$screenId/name",
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

  /// 스크린 이름 변경
  Future<ApiResponse<void>> postDevicesContents(List<int> screenIds, String contentType, int contentId) async {
    final response = await Service.patchApi(
      type: ServiceType.Device,
      endPoint: "contents",
      jsonBody: {"screenIds": screenIds, "contentType": contentType, "contentId": contentId},
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
