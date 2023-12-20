import 'package:flutter/services.dart';

class InputFormatterUtil{

  /// @feature: 영어, 숫자, "-", "_" 만 입력 가능
  /// @author: 2023/08/18 10:34 AM donghwishin
  static FilteringTextInputFormatter onlyName(){
    return FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\-_]'));
  }

}