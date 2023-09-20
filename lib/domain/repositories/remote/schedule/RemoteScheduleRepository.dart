import 'dart:async';

import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistCreate.dart';

import '../../../../data/models/device/ResponseDeviceModel.dart';
import '../../../../data/models/playlist/RequestPlaylistUpdateInfoModel.dart';
import '../../../../data/models/playlist/ResponsePlaylistModel.dart';
import '../../../../data/models/schedule/RequestScheduleUpdateInfoModel.dart';
import '../../../../data/models/schedule/ResponseScheduleCreate.dart';
import '../../../../data/models/schedule/ResponseScheduleModel.dart';

abstract class RemoteScheduleRepository {
  /// 스케줄 리스트 목록 조회
  Future<ApiListResponse<List<ResponseScheduleModel>>> getSchedules();

  /// 스줄케줄 정보 조회
  Future<ApiResponse<ResponseScheduleModel>> getSchedule(int scheduleId);

  /// 스케줄 등록
  Future<ApiResponse<ResponseScheduleCreate>> postSchedule(RequestScheduleUpdateInfoModel data);

  /// 스케줄 정보 업데이트
  Future<ApiResponse<void>> patchSchedule(int scheduleId, RequestScheduleUpdateInfoModel data);

  /// 스케줄 삭제
  Future<ApiResponse<void>> delSchedule(int scheduleId);

}
