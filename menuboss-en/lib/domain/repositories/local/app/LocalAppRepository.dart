import 'package:menuboss_common/components/bottom_sheet/BottomSheetFilterSelector.dart';

abstract class LocalAppRepository {
  /// 로그인 후 발급 받은 토큰 가져오기
  Future<String> getLoginAccessToken();

  /// 로그인 후 발급 받은 토큰 저장하기
  Future<void> setLoginAccessToken(String token);

  /// 미디어 필터 타입 가져오기
  Future<FilterType> getMediaFilterType(Map<FilterType, String> filterValues);

  /// 미디어 필터 타입 저장하기
  Future<void> setMediaFilterType(FilterType type, Map<FilterType, String> filterValues);
}
