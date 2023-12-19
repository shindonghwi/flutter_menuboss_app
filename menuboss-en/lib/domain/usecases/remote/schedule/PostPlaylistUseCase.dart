import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/schedule/RequestScheduleUpdateInfoModel.dart';
import 'package:menuboss/data/models/schedule/ResponseScheduleCreate.dart';
import 'package:menuboss/domain/repositories/remote/schedule/RemoteScheduleRepository.dart';

class PostScheduleUseCase {
  PostScheduleUseCase();

  final RemoteScheduleRepository _remoteScheduleRepository = GetIt.instance<RemoteScheduleRepository>();

  Future<ApiResponse<ResponseScheduleCreate>> call(RequestScheduleUpdateInfoModel data) async {
    return await _remoteScheduleRepository.postSchedule(data);
  }
}
