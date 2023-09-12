import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/auth/RequestEmailLoginModel.dart';
import 'package:menuboss/data/models/auth/ResponseLoginModel.dart';
import 'package:menuboss/firebase/FirebaseCloudMessage.dart';

import '../../../../data/models/ApiResponse.dart';
import '../../../../data/models/auth/RequestSocialLoginModel.dart';
import '../../../models/auth/LoginPlatform.dart';
import '../../../repositories/remote/auth/RemoteAuthRepository.dart';

class PostEmailLoginUseCase {
  PostEmailLoginUseCase();

  final RemoteAuthRepository _remoteAuthRepository = GetIt.instance<RemoteAuthRepository>();

  Future<ApiResponse<ResponseLoginModel>> call({
    required String email,
    required String password,
    String deviceToken = "",
  }) async {
    final token = deviceToken.toString().isNotEmpty ? deviceToken : await FirebaseCloudMessage.getToken() ?? "";

    final res = await _remoteAuthRepository.postEmailLogin(
      requestEmailLoginModel: RequestEmailLoginModel(
        email: email,
        password: password,
        deviceToken: token,
      ),
    );

    return res;
  }
}
