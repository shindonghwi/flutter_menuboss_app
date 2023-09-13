import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/ApiResponse.dart';
import 'package:menuboss/domain/repositories/remote/device/RemoteDeviceRepository.dart';

class PostDevicesContentsUseCase {
  PostDevicesContentsUseCase();

  final RemoteDeviceRepository _remoteDeviceRepository = GetIt.instance<RemoteDeviceRepository>();

  Future<ApiResponse<void>> call(List<int> screenIds, String contentType, int contentId) async {
    return await _remoteDeviceRepository.postDevicesContents(screenIds, contentType, contentId);
  }
}
