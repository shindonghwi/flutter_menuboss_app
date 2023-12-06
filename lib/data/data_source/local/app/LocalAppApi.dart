import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetFilterSelector.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../SharedKey.dart';

class LocalAppApi {
  LocalAppApi();

  final String accessTokenKey = SharedKeyHelper.fromString(SharedKey.ACCESS_TOKEN);
  final String mediaFilterTypeKey = SharedKeyHelper.fromString(SharedKey.MEDIA_FILTER_TYPE);

  Future<String> getLoginAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(accessTokenKey) ?? "";
  }

  Future<void> setLoginAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(accessTokenKey, token);
  }

  Future<FilterType> getMediaFilterType(Map<FilterType, String> filterValues) async {
    final prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString(mediaFilterTypeKey);
    return _stringToFilterType(stringValue ?? filterValues[FilterType.NewestFirst]!, filterValues);
  }

  Future<void> setMediaFilterType(FilterType type, Map<FilterType, String> filterValues) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(mediaFilterTypeKey, filterValues[type]!);
  }

  FilterType _stringToFilterType(String value, Map<FilterType, String> filterValues) {
    return filterValues.entries.firstWhere((entry) => entry.value == value).key;
  }
}
