import 'package:shared_preferences/shared_preferences.dart';

import '../SharedKey.dart';

class LocalAppApi {
  LocalAppApi();

  final String accessTokenKey = SharedKeyHelper.fromString(SharedKey.ACCESS_TOKEN);

  Future<String> getLoginAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(accessTokenKey) ?? "";
  }

  Future<void> setLoginAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(accessTokenKey, token);
  }
}
