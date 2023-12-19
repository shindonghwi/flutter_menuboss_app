import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/domain/repositories/remote/schedule/RemoteScheduleRepository.dart';

import '../../../../data/models/schedule/ResponseScheduleModel.dart';

class GetScheduleUseCase {
  GetScheduleUseCase();

  final RemoteScheduleRepository _remoteScheduleRepository = GetIt.instance<RemoteScheduleRepository>();

  Future<ApiResponse<ResponseScheduleModel>> call(int scheduleId) async {
    return await _remoteScheduleRepository.getSchedule(scheduleId);
  }
}
