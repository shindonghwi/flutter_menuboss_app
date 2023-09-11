import 'package:get_it/get_it.dart';

import '../../../../domain/repositories/local/app/LocalAppRepository.dart';
import '../../../data_source/local/app/LocalAppApi.dart';

class LocalAppRepositoryImpl implements LocalAppRepository {
  LocalAppRepositoryImpl();

  @override
  Future<String> getLoginAccessToken() {
    LocalAppApi localAppApi = GetIt.instance<LocalAppApi>();
    return localAppApi.getLoginAccessToken();
  }

  @override
  Future<void> setLoginAccessToken(String token) {
    LocalAppApi localAppApi = GetIt.instance<LocalAppApi>();
    return localAppApi.setLoginAccessToken(token);
  }
}
