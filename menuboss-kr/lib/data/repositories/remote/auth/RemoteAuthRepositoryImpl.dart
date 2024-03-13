import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/auth/RequestEmailLoginModel.dart';
import 'package:menuboss/data/models/auth/RequestSocialLoginModel.dart';
import 'package:menuboss/data/models/auth/ResponseLoginModel.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/domain/models/auth/SocialLoginModel.dart';

import '../../../../domain/repositories/remote/auth/RemoteAuthRepository.dart';
import '../../../data_source/remote/auth/RemoteAuthApi.dart';

class RemoteAuthRepositoryImpl implements RemoteAuthRepository {
  RemoteAuthRepositoryImpl();

  RemoteAuthApi remoteAuthApi = GetIt.instance<RemoteAuthApi>();

  @override
  Future<ApiResponse<SocialLoginModel>> doAppleLogin() {
    return remoteAuthApi.doAppleLogin();
  }

  @override
  Future<ApiResponse<SocialLoginModel>> doKakaoLogin() {
    return remoteAuthApi.doKakaoLogin();
  }

  @override
  Future<ApiResponse<ResponseLoginModel>> postSocialLogin({
    required RequestSocialLoginModel requestSocialLoginModel,
  }) {
    return remoteAuthApi.postSocialLogin(
      requestSocialLoginModel: requestSocialLoginModel,
    );
  }

  @override
  Future<ApiResponse<ResponseLoginModel>> postEmailLogin({
    required RequestEmailLoginModel requestEmailLoginModel,
  }) {
    return remoteAuthApi.postEmailLogin(
      requestEmailLoginModel: requestEmailLoginModel,
    );
  }

  @override
  Future<ApiResponse<void>> postLogout() {
    return remoteAuthApi.postLogout();
  }
}
