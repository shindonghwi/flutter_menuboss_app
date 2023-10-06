import 'package:get_it/get_it.dart';
import 'package:menuboss/data/data_source/remote/schedule/RemoteScheduleApi.dart';
import 'package:menuboss/data/models/base/ApiListResponse.dart';

import '../../../../domain/repositories/remote/schedule/RemoteScheduleRepository.dart';
import '../../../models/base/ApiResponse.dart';
import '../../../models/schedule/RequestScheduleUpdateInfoModel.dart';
import '../../../models/schedule/ResponseScheduleCreate.dart';
import '../../../models/schedule/ResponseScheduleModel.dart';
import '../../../models/schedule/ResponseSchedulesModel.dart';

class RemoteScheduleRepositoryImpl implements RemoteScheduleRepository {
  RemoteScheduleRepositoryImpl();

  final RemoteScheduleApi _remoteScheduleApi = GetIt.instance<RemoteScheduleApi>();

  @override
  Future<ApiListResponse<List<ResponseSchedulesModel>>> getSchedules() {
    return _remoteScheduleApi.getSchedules();
  }

  @override
  Future<ApiResponse<ResponseScheduleModel>> getSchedule(int scheduleId) {
    return _remoteScheduleApi.getSchedule(scheduleId);
  }

  @override
  Future<ApiResponse<ResponseScheduleCreate>> postSchedule(RequestScheduleUpdateInfoModel data) {
    return _remoteScheduleApi.postSchedule(data);
  }

  @override
  Future<ApiResponse<void>> patchSchedule(int scheduleId, RequestScheduleUpdateInfoModel data) {
    return _remoteScheduleApi.patchSchedule(scheduleId, data);
  }

  @override
  Future<ApiResponse<void>> delSchedule(int scheduleId) {
    return _remoteScheduleApi.delSchedule(scheduleId);
  }
}
