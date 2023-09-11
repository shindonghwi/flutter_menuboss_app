import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../../../repositories/local/app/LocalAppRepository.dart';

class GetLoginAccessTokenUseCase {
  GetLoginAccessTokenUseCase();

  final LocalAppRepository _localAppRepository = GetIt.instance<LocalAppRepository>();

  Future<String> call() async {
    final accessToken = await _localAppRepository.getLoginAccessToken();
    debugPrint("local accessToken: $accessToken");
    return accessToken;
  }
}
