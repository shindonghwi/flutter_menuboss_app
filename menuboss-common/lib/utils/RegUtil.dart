class RegUtil {
  static bool checkEmail(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  static bool checkPw(String pw) {
    final regex =
        RegExp(r'^(?=.*[a-zA-Z가-힣])(?=.*\d)[a-zA-Z가-힣\d!@#$%^&*()_+,\\.<>?;:{}\[\]=\-~]{8,20}$');
    return regex.hasMatch(pw);
  }

  static bool checkNickname(String nickname) {
    final regex = RegExp(r'^[a-zA-Z0-9_가-힣]{2,8}$');
    return regex.hasMatch(nickname);
  }

  static bool checkKrPhone(String phone) {
    final regex = RegExp(r'^\d{3}-\d{4}-\d{4}$');
    return regex.hasMatch(phone);
  }

  static bool checkUsPhone(String phone) {
    final regex = RegExp(r'^\d{3}-\d{3}-\d{4}$');
    return regex.hasMatch(phone);
  }
}

enum RegCheckType { Email, PW, Nickname }
