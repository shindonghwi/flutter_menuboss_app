import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/device/RequestDeviceApplyContents.dart';
import 'package:menuboss/domain/repositories/remote/device/RemoteDeviceRepository.dart';

class PostShowNameEventUseCase {
  PostShowNameEventUseCase();

  final RemoteDeviceRepository _remoteDeviceRepository = GetIt.instance<RemoteDeviceRepository>();

  Future<ApiResponse<void>> call(int screenId) async {
    return await _remoteDeviceRepository.sendShowNameEvent(screenId);
  }
}
