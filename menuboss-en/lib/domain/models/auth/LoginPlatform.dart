enum LoginPlatform {
  Google,
  Kakao,
  Apple,
  None,
}


class LoginPlatformHelper {
  static const Map<LoginPlatform, String> _stringToEnum = {
    LoginPlatform.Google: "Google",
    LoginPlatform.Kakao: "Kakao",
    LoginPlatform.Apple: "Apple",
    LoginPlatform.None: "none"
  };

  static String fromString(LoginPlatform platform) => _stringToEnum[platform] ?? "";
}
