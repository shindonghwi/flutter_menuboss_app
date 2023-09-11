abstract class LocalAppRepository {
  /// 로그인 후 발급 받은 토큰 가져오기
  Future<String> getLoginAccessToken();

  /// 로그인 후 발급 받은 토큰 저장하기
  Future<void> setLoginAccessToken(String token);
}
