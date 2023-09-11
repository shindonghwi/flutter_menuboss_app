import 'package:get_it/get_it.dart';

import '../../../../data/models/ApiResponse.dart';
import '../../../models/auth/SocialLoginModel.dart';
import '../../../repositories/remote/auth/RemoteAuthRepository.dart';

class PostGoogleSignInUseCase {
  PostGoogleSignInUseCase();

  final RemoteAuthRepository _remoteAuthRepository = GetIt.instance<RemoteAuthRepository>();

  Future<ApiResponse<SocialLoginModel>> call() async {
    return await _remoteAuthRepository.doGoogleLogin();
  }

}
