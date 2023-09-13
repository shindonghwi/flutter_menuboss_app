import 'package:get_it/get_it.dart';

import '../../../../domain/repositories/local/app/LocalAppRepository.dart';
import '../../../data_source/local/app/LocalAppApi.dart';

class LocalAppRepositoryImpl implements LocalAppRepository {
  LocalAppRepositoryImpl();

  LocalAppApi localAppApi = GetIt.instance<LocalAppApi>();

  @override
  Future<String> getLoginAccessToken() {
    return localAppApi.getLoginAccessToken();
  }

  @override
  Future<void> setLoginAccessToken(String token) {
    return localAppApi.setLoginAccessToken(token);
  }
}
