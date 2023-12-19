enum LoginPlatform {
  Google,
  Kakao,
  Apple,
  None,
}


class LoginPlatformHelper {
  static const Map<LoginPlatform, String> _stringToEnum = {
    LoginPlatform.Google: "google",
    LoginPlatform.Kakao: "kakao",
    LoginPlatform.Apple: "apple",
    LoginPlatform.None: "none"
  };

  static String fromString(LoginPlatform platform) => _stringToEnum[platform] ?? "";
}
