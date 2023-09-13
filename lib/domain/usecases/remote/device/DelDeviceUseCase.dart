import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/ApiListResponse.dart';
import 'package:menuboss/data/models/ApiResponse.dart';
import 'package:menuboss/data/models/device/ResponseDeviceModel.dart';
import 'package:menuboss/domain/repositories/remote/device/RemoteDeviceRepository.dart';

class DelDeviceUseCase {
  DelDeviceUseCase();

  final RemoteDeviceRepository _remoteDeviceRepository = GetIt.instance<RemoteDeviceRepository>();

  Future<ApiResponse<void>> call(int screenId) async {
    return await _remoteDeviceRepository.delDevice(screenId);
  }
}
