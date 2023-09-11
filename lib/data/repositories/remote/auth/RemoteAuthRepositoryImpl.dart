import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/ApiResponse.dart';
import 'package:menuboss/data/models/auth/RequestEmailLoginModel.dart';
import 'package:menuboss/data/models/auth/RequestSocialLoginModel.dart';
import 'package:menuboss/data/models/auth/ResponseLoginModel.dart';
import 'package:menuboss/domain/models/auth/SocialLoginModel.dart';

import '../../../../domain/repositories/remote/auth/RemoteAuthRepository.dart';
import '../../../data_source/remote/auth/RemoteAuthApi.dart';

class RemoteAuthRepositoryImpl implements RemoteAuthRepository {
  RemoteAuthRepositoryImpl();

  @override
  Future<ApiResponse<SocialLoginModel>> doAppleLogin() {
    RemoteAuthApi remoteAuthApi = GetIt.instance<RemoteAuthApi>();
    return remoteAuthApi.doAppleLogin();
  }

  @override
  Future<ApiResponse<SocialLoginModel>> doGoogleLogin() {
    RemoteAuthApi remoteAuthApi = GetIt.instance<RemoteAuthApi>();
    return remoteAuthApi.doGoogleLogin();
  }

  @override
  Future<ApiResponse<ResponseLoginModel>> postSocialLogin({
    required RequestSocialLoginModel requestSocialLoginModel,
  }) {
    RemoteAuthApi remoteAuthApi = GetIt.instance<RemoteAuthApi>();
    return remoteAuthApi.postSocialLogin(
      requestSocialLoginModel: requestSocialLoginModel,
    );
  }

  @override
  Future<ApiResponse<ResponseLoginModel>> postEmailLogin({
    required RequestEmailLoginModel requestEmailLoginModel,
  }) {
    RemoteAuthApi remoteAuthApi = GetIt.instance<RemoteAuthApi>();
    return remoteAuthApi.postEmailLogin(
      requestEmailLoginModel: requestEmailLoginModel,
    );
  }

  @override
  Future<ApiResponse<void>> postLogout() {
    RemoteAuthApi remoteAuthApi = GetIt.instance<RemoteAuthApi>();
    return remoteAuthApi.postLogout();
  }

}
