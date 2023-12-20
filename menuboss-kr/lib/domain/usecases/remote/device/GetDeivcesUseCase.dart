import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/device/ResponseDeviceModel.dart';
import 'package:menuboss/domain/repositories/remote/device/RemoteDeviceRepository.dart';

class GetDevicesUseCase {
  GetDevicesUseCase();

  final RemoteDeviceRepository _remoteDeviceRepository = GetIt.instance<RemoteDeviceRepository>();

  Future<ApiListResponse<List<ResponseDeviceModel>>> call() async {
    return await _remoteDeviceRepository.getDevices();
  }
}
