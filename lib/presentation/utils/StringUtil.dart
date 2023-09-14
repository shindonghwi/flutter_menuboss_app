import 'dart:convert';

class StringUtil{

  /// json map을 pretty json으로 변환하여 반환합니다.
  static String convertPrettyJson(Map<String, dynamic> jsonMap) {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(jsonMap);
  }

  /// bytes int 정보를 메가바이트로 변환하여 반환합니다.
  static String formatBytesToMegabytes(int bytes) {
    double megabytes = bytes / (1024 * 1024);
    return '${megabytes.toStringAsFixed(1)}MB';
  }


}