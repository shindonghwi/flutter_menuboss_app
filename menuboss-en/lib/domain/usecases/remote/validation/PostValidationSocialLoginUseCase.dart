import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/me/RequestMeJoinModel.dart';
import 'package:menuboss/data/models/me/ResponseMeAuthorization.dart';
import 'package:menuboss/data/models/me/ResponseMeInfoModel.dart';
import 'package:menuboss/domain/repositories/remote/me/RemoteMeRepository.dart';
import 'package:menuboss/domain/repositories/remote/validation/RemoteValidationRepository.dart';

class PostValidationSocialLoginUseCase {
  PostValidationSocialLoginUseCase();

  final RemoteValidationRepository _remoteValidationRepository = GetIt.instance<RemoteValidationRepository>();

  Future<ApiResponse<void>> call(String type, String accessToken) async {
    return await _remoteValidationRepository.verifySocialLogin(type, accessToken);
  }
}
