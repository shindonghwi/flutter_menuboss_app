import 'package:get_it/get_it.dart';

import '../../../repositories/local/app/LocalAppRepository.dart';

class PostLoginAccessTokenUseCase {
  PostLoginAccessTokenUseCase();

  final LocalAppRepository _localAppRepository = GetIt.instance<LocalAppRepository>();

  Future<void> call(String token) async {
    return await _localAppRepository.setLoginAccessToken(token);
  }
}
