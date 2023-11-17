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
    try {
      final response = await Service.getApi(
        type: ServiceType.Schedule,
        endPoint: null,
      );

      final errorResponse = BaseApiUtil.isErrorStatusCode(response);
      if (errorResponse != null) {
        return BaseApiUtil.errorListResponse(
          status: errorResponse.status,
          message: errorResponse.message,
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
    } catch (e) {
      return BaseApiUtil.errorListResponse(
        message: e.toString(),
      );
    }
  }

  /// 스케줄 정보 조회
  Future<ApiResponse<ResponseScheduleModel>> getSchedule(int scheduleId) async {
    try {
      final response = await Service.getApi(
        type: ServiceType.Schedule,
        endPoint: "$scheduleId",
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
          (json) => ResponseScheduleModel.fromJson(json),
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// 스케줄 등록
  /// return scheduleId
  Future<ApiResponse<ResponseScheduleCreate>> postSchedule(RequestScheduleUpdateInfoModel data) async {
    try {
      final response = await Service.postApi(
        type: ServiceType.Schedule,
        endPoint: null,
        jsonBody: data.toJson(),
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
          (json) => ResponseScheduleCreate.fromJson(json),
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// 스케줄 정보 업데이트
  Future<ApiResponse<void>> patchSchedule(int scheduleId, RequestScheduleUpdateInfoModel data) async {
    try {
      final response = await Service.patchApi(
        type: ServiceType.Schedule,
        endPoint: "$scheduleId",
        jsonBody: data.toJson(),
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
          (json) {},
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// 스케줄 삭제
  Future<ApiResponse<void>> delSchedule(int scheduleId) async {
    try {
      final response = await Service.deleteApi(
        type: ServiceType.Schedule,
        endPoint: "$scheduleId",
        jsonBody: null,
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
          (json) {},
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }
}
