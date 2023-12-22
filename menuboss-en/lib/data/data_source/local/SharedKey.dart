enum SharedKey {
  MEDIA_FILTER_TYPE, // 미디어 필터 타입
  ACCESS_TOKEN, // 앱 로그인 토큰
}

class SharedKeyHelper {
  static const Map<SharedKey, String> _stringToEnum = {
    SharedKey.MEDIA_FILTER_TYPE: "MEDIA_FILTER_TYPE",
    SharedKey.ACCESS_TOKEN: "ACCESS_TOKEN",
  };

  static String fromString(SharedKey key) => _stringToEnum[key]!;
}