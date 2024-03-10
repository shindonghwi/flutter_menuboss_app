import 'package:get_it/get_it.dart';
import 'package:menuboss/data/data_source/remote/app/RemoteAppApi.dart';
import 'package:menuboss/data/models/app/ResponseAppCheckUpModel.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import '../../../../domain/repositories/remote/app/RemoteAppRepository.dart';

class RemoteAppRepositoryImpl implements RemoteAppRepository {
  RemoteAppRepositoryImpl();

  final RemoteAppApi _remoteAppApi = GetIt.instance<RemoteAppApi>();

  @override
  Future<ApiResponse<ResponseAppCheckUpModel>> checkApp() {
    return _remoteAppApi.checkApp();
  }
}
