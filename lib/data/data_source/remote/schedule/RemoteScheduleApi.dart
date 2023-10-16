import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/schedule/ResponseScheduleCreate.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../../../models/schedule/RequestScheduleUpdateInfoModel.dart';
import '../../../models/schedule/ResponseScheduleModel.dart';
import '../../../models/schedule/ResponseSchedulesModel.dart';
import '../BaseApiUtil.dart';
import '../Service.dart';

class RemoteScheduleApi {
  RemoteScheduleApi();

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  /// 스케줄 리스트 목록 조회
  Future<ApiListResponse<List<ResponseSchedulesModel>>> getSchedules() async {
    final response = await Service.getApi(
      type: ServiceType.Schedule,
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
          return List<ResponseSchedulesModel>.from(
            json.map((item) => ResponseSchedulesModel.fromJson(item as Map<String, dynamic>)),
          );
        },
      );
    }
  }

  /// 스케줄 정보 조회
  Future<ApiResponse<ResponseScheduleModel>> getSchedule(int scheduleId) async {
    final response = await Service.getApi(
      type: ServiceType.Schedule,
      endPoint: "$scheduleId",
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
        (json) => ResponseScheduleModel.fromJson(json),
      );
    }
  }

  /// 스케줄 등록
  /// return scheduleId
  Future<ApiResponse<ResponseScheduleCreate>> postSchedule(RequestScheduleUpdateInfoModel data) async {
    final response = await Service.postApi(
      type: ServiceType.Schedule,
      endPoint: null,
      jsonBody: data.toJson(),
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
        (json) => ResponseScheduleCreate.fromJson(json),
      );
    }
  }

  /// 스케줄 정보 업데이트
  Future<ApiResponse<void>> patchSchedule(int scheduleId, RequestScheduleUpdateInfoModel data) async {
    final response = await Service.patchApi(
      type: ServiceType.Schedule,
      endPoint: "$scheduleId",
      jsonBody: data.toJson(),
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

  /// 스케줄 삭제
  Future<ApiResponse<void>> delSchedule(int scheduleId) async {
    final response = await Service.deleteApi(
      type: ServiceType.Schedule,
      endPoint: "$scheduleId",
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
}
