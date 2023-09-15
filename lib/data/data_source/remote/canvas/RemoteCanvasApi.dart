import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../../../models/canvas/ResponseCanvasModel.dart';
import '../../../models/device/ResponseDeviceModel.dart';
import '../BaseApiUtil.dart';
import '../Service.dart';

class RemoteCanvasApi {
  RemoteCanvasApi();

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  /// 캔버스 목록 조회
  Future<ApiListResponse<List<ResponseCanvasModel>>> getCanvases() async {
    final response = await Service.getApi(
      type: ServiceType.Canvas,
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
          return List<ResponseCanvasModel>.from(
            json.map((item) => ResponseCanvasModel.fromJson(item as Map<String, dynamic>)),
          );
        },
      );
    }
  }

}
