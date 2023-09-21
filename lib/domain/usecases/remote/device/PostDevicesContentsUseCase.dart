import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/device/RequestDeviceApplyContents.dart';
import 'package:menuboss/domain/repositories/remote/device/RemoteDeviceRepository.dart';

class PostDevicesContentsUseCase {
  PostDevicesContentsUseCase();

  final RemoteDeviceRepository _remoteDeviceRepository = GetIt.instance<RemoteDeviceRepository>();

  Future<ApiResponse<void>> call(RequestDeviceApplyContents model) async {
    return await _remoteDeviceRepository.postDevicesContents(model);
  }
}
