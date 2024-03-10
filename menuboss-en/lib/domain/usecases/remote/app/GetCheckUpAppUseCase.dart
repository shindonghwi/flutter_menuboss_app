import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/app/ResponseAppCheckUpModel.dart';
import 'package:menuboss/domain/repositories/remote/app/RemoteAppRepository.dart';

import '../../../../data/models/base/ApiResponse.dart';

class GetCheckUpAppUseCase {
  GetCheckUpAppUseCase();

  final RemoteAppRepository _remoteAppRepository = GetIt.instance<RemoteAppRepository>();

  Future<ApiResponse<ResponseAppCheckUpModel>> call() async {
    return await _remoteAppRepository.checkApp();
  }
}
