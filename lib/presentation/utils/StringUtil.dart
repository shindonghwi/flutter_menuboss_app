import 'dart:convert';

import 'package:intl/intl.dart';

import 'dto/Triple.dart';

class StringUtil {
  /// json map을 pretty json으로 변환하여 반환합니다.
  static String convertPrettyJson(Map<String, dynamic> jsonMap) {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(jsonMap);
  }

  /// bytes int 정보를 메가바이트로 변환하여 반환합니다.
  static String formatBytesToMegabytes(int bytes) {
    double megabytes = bytes / (1024 * 1024);
    double kilobytes = bytes / 1024;

    if (megabytes >= 0.1) {
      return '${megabytes.toStringAsFixed(1)}MB';
    } else if (kilobytes >= 10) {
      return '0.1MB';
    } else if (kilobytes >= 1) {
      return '${kilobytes.toStringAsFixed(0)}KB';
    } else {
      return '${bytes}B';
    }
  }



  /// url에서 파일 확장자를 추출하여 반환합니다.
  static String? extractFileExtensionFromUrl(String? url) {
    return url?.split('.').last;
  }

  /// 주어진 시간(초) 정보를 포맷에 맞게 변환하여 반환합니다. "00:01:01"
  static String formatDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  /// "00:01:01"를 받아서 시간, 분, 초를 반환합니다
  static Triple parseDuration(String duration) {
    final durationSplit = duration.split(":");

    if (durationSplit.length != 3) {
      return Triple("00", "00", "00");
    }

    return Triple(
      durationSplit[0].padLeft(2, '0'),
      durationSplit[1].padLeft(2, '0'),
      durationSplit[2].padLeft(2, '0'),
    );
  }

  /// "00:01:01"를 받아서 초로 변환하여 반환합니다.
  static int convertToSeconds(int hours, int minutes, int seconds) {
    return hours * 3600 + minutes * 60 + seconds;
  }

  /// "Sep 15, 2023, 9:30 AM" 형식의 문자열을 "Sep 15, 2023"로 변환합니다.
  static String formatSimpleDate(String input) {
    DateTime parsedDate = DateFormat('MMM d, y, h:mm a').parse(input);
    return DateFormat('MMM d, y').format(parsedDate);
  }


}
