import 'dart:async';

import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';

import '../../../../data/models/device/RequestDeviceApplyContents.dart';
import '../../../../data/models/device/ResponseDeviceModel.dart';

abstract class RemoteDeviceRepository {
  /// 스크린 목록 조회
  Future<ApiListResponse<List<ResponseDeviceModel>>> getDevices();

  /// 스크린 등록
  Future<ApiResponse<void>> postDevice(String code);

  /// 스크린 삭제
  Future<ApiResponse<void>> delDevice(int screenId);

  /// 스크린 이름 변경
  Future<ApiResponse<void>> patchDeviceName(int screenId, String name);

  /// 스크린 목록에 콘텐츠 적용
  Future<ApiResponse<void>> postDevicesContents(RequestDeviceApplyContents model);

}
