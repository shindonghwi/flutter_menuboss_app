import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/schedule/RequestScheduleUpdateInfoModel.dart';
import 'package:menuboss/domain/repositories/remote/schedule/RemoteScheduleRepository.dart';

class PatchScheduleUseCase {
  PatchScheduleUseCase();

  final RemoteScheduleRepository _remoteScheduleRepository = GetIt.instance<RemoteScheduleRepository>();

  Future<ApiResponse<void>> call(int scheduleId, RequestScheduleUpdateInfoModel data) async {
    return await _remoteScheduleRepository.patchSchedule(scheduleId, data);
  }
}
