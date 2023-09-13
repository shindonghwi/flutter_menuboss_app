import 'dart:async';

import 'package:menuboss/data/models/ApiListResponse.dart';

import '../../../../data/models/device/ResponseDeviceModel.dart';

abstract class RemoteDeviceRepository {
  /// 스크린 목록 조회
  Future<ApiListResponse<List<ResponseDeviceModel>>> getDevices();
}
