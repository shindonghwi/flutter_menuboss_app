import 'package:get_it/get_it.dart';
import 'package:menuboss/data/data_source/remote/validation/RemoteValidationApi.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/auth/RequestEmailLoginModel.dart';
import 'package:menuboss/data/models/auth/RequestSocialLoginModel.dart';
import 'package:menuboss/data/models/auth/ResponseLoginModel.dart';
import 'package:menuboss/domain/models/auth/SocialLoginModel.dart';

import '../../../../domain/repositories/remote/auth/RemoteAuthRepository.dart';
import '../../../../domain/repositories/remote/validation/RemoteValidationRepository.dart';
import '../../../data_source/remote/auth/RemoteAuthApi.dart';

class RemoteValidationRepositoryImpl implements RemoteValidationRepository {
  RemoteValidationRepositoryImpl();

  final RemoteValidationApi _remoteValidationApi = GetIt.instance<RemoteValidationApi>();

  @override
  Future<ApiResponse<void>> verifySocialLogin(String type, String accessToken) {
    return _remoteValidationApi.postSocialVerify(type, accessToken);
  }
}
