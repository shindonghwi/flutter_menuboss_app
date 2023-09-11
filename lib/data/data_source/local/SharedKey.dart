enum SharedKey {
  APP_USE_POLICY, // 앱 사용 약관 동의
  ACCESS_TOKEN, // 앱 로그인 토큰
}

class SharedKeyHelper {
  static const Map<SharedKey, String> _stringToEnum = {
    SharedKey.APP_USE_POLICY: "APP_USE_POLICY",
    SharedKey.ACCESS_TOKEN: "ACCESS_TOKEN",
  };

  static String fromString(SharedKey key) => _stringToEnum[key]!;
}
