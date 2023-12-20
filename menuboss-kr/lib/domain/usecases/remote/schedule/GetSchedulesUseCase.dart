import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/schedule/ResponseSchedulesModel.dart';
import 'package:menuboss/domain/repositories/remote/schedule/RemoteScheduleRepository.dart';

class GetSchedulesUseCase {
  GetSchedulesUseCase();

  final RemoteScheduleRepository _remoteScheduleRepository = GetIt.instance<RemoteScheduleRepository>();

  Future<ApiListResponse<List<ResponseSchedulesModel>>> call() async {
    return await _remoteScheduleRepository.getSchedules();
  }
}
