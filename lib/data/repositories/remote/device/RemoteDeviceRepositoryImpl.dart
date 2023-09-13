import 'package:get_it/get_it.dart';
import 'package:menuboss/data/data_source/remote/device/RemoteDeviceApi.dart';
import 'package:menuboss/data/models/ApiListResponse.dart';

import '../../../../domain/repositories/remote/device/RemoteDeviceRepository.dart';
import '../../../../domain/repositories/remote/me/RemoteMeRepository.dart';
import '../../../data_source/remote/me/RemoteMeApi.dart';
import '../../../models/ApiResponse.dart';
import '../../../models/device/ResponseDeviceModel.dart';
import '../../../models/me/ResponseMeInfoModel.dart';

class RemoteDeviceRepositoryImpl implements RemoteDeviceRepository {
  RemoteDeviceRepositoryImpl();

  final RemoteDeviceApi _remoteDeviceApi = GetIt.instance<RemoteDeviceApi>();

  @override
  Future<ApiListResponse<List<ResponseDeviceModel>>> getDevices() {
    return _remoteDeviceApi.getDevices();
  }

  @override
  Future<ApiResponse<void>> postDevice(String code) {
    return _remoteDeviceApi.postDevice(code);
  }

}
