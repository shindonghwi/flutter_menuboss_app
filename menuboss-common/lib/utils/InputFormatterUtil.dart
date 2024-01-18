import 'package:flutter/services.dart';

class InputFormatterUtil{

  /// @feature: 영어, 숫자, "-", "_" 만 입력 가능
  /// @author: 2023/08/18 10:34 AM donghwishin
  static FilteringTextInputFormatter onlyName(){
    return FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\-_]'));
  }

  /// Formats input as a U.S. phone number (XXX-XXX-XXXX).
  /// @author: 2024/01/18 10:00 AM
  static TextInputFormatter usPhoneNumber() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String newText = newValue.text;
      if (newValue.text.length > oldValue.text.length) {
        if (newText.length == 4 || newText.length == 8) {
          newText = '${newText.substring(0, newText.length - 1)}-${newText.substring(newText.length - 1)}';
        }
        if (newText.length > 12) {
          newText = newText.substring(0, 12);
        }
      }
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    });
  }

  /// Formats input as a K.R phone number (XXX-XXXX-XXXX).
  /// @author: 2024/01/18 10:00 AM
  static TextInputFormatter krPhoneNumber() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String newText = newValue.text;
      if (newValue.text.length > oldValue.text.length) {
        if (newText.length == 4 || newText.length == 9) {
          newText = '${newText.substring(0, newText.length - 1)}-${newText.substring(newText.length - 1)}';
        }
        if (newText.length > 13) {
          newText = newText.substring(0, 13);
        }
      }
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    });
  }


}