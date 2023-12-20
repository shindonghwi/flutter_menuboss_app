import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/domain/repositories/remote/schedule/RemoteScheduleRepository.dart';

class DelScheduleUseCase {
  DelScheduleUseCase();

  final RemoteScheduleRepository _remoteScheduleRepository = GetIt.instance<RemoteScheduleRepository>();

  Future<ApiResponse<void>> call(int scheduleId) async {
    return await _remoteScheduleRepository.delSchedule(scheduleId);
  }
}
