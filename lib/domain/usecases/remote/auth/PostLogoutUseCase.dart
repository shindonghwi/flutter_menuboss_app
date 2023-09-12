import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/auth/RequestEmailLoginModel.dart';
import 'package:menuboss/data/models/auth/ResponseLoginModel.dart';
import 'package:menuboss/firebase/FirebaseCloudMessage.dart';

import '../../../../data/models/ApiResponse.dart';
import '../../../../data/models/auth/RequestSocialLoginModel.dart';
import '../../../models/auth/LoginPlatform.dart';
import '../../../repositories/remote/auth/RemoteAuthRepository.dart';

class PostLogoutUseCase {
  PostLogoutUseCase();

  final RemoteAuthRepository _remoteAuthRepository = GetIt.instance<RemoteAuthRepository>();

  Future<ApiResponse<void>> call() async {
    return await _remoteAuthRepository.postLogout();
  }
}
