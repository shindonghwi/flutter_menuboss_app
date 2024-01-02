import 'package:get_it/get_it.dart';

import '../../../../data/models/base/ApiResponse.dart';
import '../../../models/auth/SocialLoginModel.dart';
import '../../../repositories/remote/auth/RemoteAuthRepository.dart';

class PostKakaoSignInUseCase {
  PostKakaoSignInUseCase();

  final RemoteAuthRepository _remoteAuthRepository = GetIt.instance<RemoteAuthRepository>();

  Future<ApiResponse<SocialLoginModel>> call() async {
    return await _remoteAuthRepository.doKakaoLogin();
  }

}
