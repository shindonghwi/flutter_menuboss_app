import 'dart:convert';

class StringUtil{
  static String convertPrettyJson(Map<String, dynamic> jsonMap) {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(jsonMap);
  }
}