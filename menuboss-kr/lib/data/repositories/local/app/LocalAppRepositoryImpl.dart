import 'package:get_it/get_it.dart';
import 'package:menuboss_common/components/bottom_sheet/BottomSheetFilterSelector.dart';

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

  @override
  Future<FilterType> getMediaFilterType(Map<FilterType, String> filterValues) {
    return localAppApi.getMediaFilterType(filterValues);
  }

  @override
  Future<void> setMediaFilterType(FilterType type, Map<FilterType, String> filterValues) {
    return localAppApi.setMediaFilterType(type, filterValues);
  }
}
