import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/app/ResponseAppCheckUpModel.dart';
import 'package:menuboss/data/models/auth/RequestEmailLoginModel.dart';
import 'package:menuboss/data/models/auth/ResponseLoginModel.dart';
import 'package:menuboss/domain/repositories/remote/app/RemoteAppRepository.dart';
import 'package:menuboss/firebase/FirebaseCloudMessage.dart';

import '../../../../data/models/base/ApiResponse.dart';
import '../../../../data/models/auth/RequestSocialLoginModel.dart';
import '../../../models/auth/LoginPlatform.dart';
import '../../../repositories/remote/auth/RemoteAuthRepository.dart';

class GetCheckUpAppUseCase {
  GetCheckUpAppUseCase();

  final RemoteAppRepository _remoteAppRepository = GetIt.instance<RemoteAppRepository>();

  Future<ApiResponse<ResponseAppCheckUpModel>> call() async {
    return await _remoteAppRepository.checkApp();
  }
}
