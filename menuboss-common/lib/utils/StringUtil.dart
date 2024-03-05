import 'dart:convert';

import 'dto/Triple.dart';

class StringUtil {
  /// json map을 pretty json으로 변환하여 반환합니다.
  static String convertPrettyJson(Map<String, dynamic> jsonMap) {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(jsonMap);
  }

  /// bytes int 정보를 메가바이트로 변환하여 반환합니다.
  static String formatBytesToMegabytes(int bytes) {
    double kilobytes = bytes / 1024;
    double megabytes = kilobytes / 1024;
    double gigabytes = megabytes / 1024;

    if (gigabytes >= 1) {
      final gbSize = gigabytes.toStringAsFixed(1);
      return gbSize.contains(".0") ? '${double.parse(gbSize).toInt()}GB' : '${gbSize}GB';
    } else if (megabytes >= 1) {
      final mbSize = megabytes.toStringAsFixed(1);
      return mbSize.contains(".0") ? '${double.parse(mbSize).toInt()}MB' : '${mbSize}MB';
    } else {
      final kbSize = kilobytes.toStringAsFixed(1);
      return kbSize.contains(".0") ? '${double.parse(kbSize).toInt()}KB' : '${kbSize}KB';
    }
  }

  /// url에서 파일 확장자를 추출하여 반환합니다.
  static String? extractFileExtensionFromUrl(String? url) {
    return url?.split('.').last;
  }

  /// 주어진 시간(초) 정보를 포맷에 맞게 변환하여 반환합니다. "00:01:01"
  static String formatDuration(double seconds) {
    final tempSecond = seconds.toInt();
    int hours = tempSecond ~/ 3600;
    int minutes = (tempSecond % 3600) ~/ 60;
    int remainingSeconds = (tempSecond % 60);

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

  /// "XXX-XXX-XXXX"를 형태로 변환하여 반환합니다.
  static String formatUsPhoneNumber(String phoneNumber) {
    int spaceIndex = phoneNumber.indexOf(' ');
    String cleanedNumber;

    if (spaceIndex != -1) {
      cleanedNumber = phoneNumber.substring(spaceIndex + 1);
    } else {
      cleanedNumber = phoneNumber;
    }
    cleanedNumber = cleanedNumber.replaceAll(RegExp(r'\D'), '');
    if (cleanedNumber.length == 10) {
      return cleanedNumber.replaceRange(3, 3, "-").replaceRange(7, 7, "-");
    } else {
      return phoneNumber;
    }
  }

  /// "XXX-XXXX-XXXX"를 형태로 변환하여 반환합니다.
  static String formatKrPhoneNumber(String phoneNumber) {
    int spaceIndex = phoneNumber.indexOf(' ');
    String cleanedNumber;

    if (spaceIndex != -1) {
      cleanedNumber = phoneNumber.substring(spaceIndex + 1);
    } else {
      cleanedNumber = phoneNumber;
    }
    cleanedNumber = cleanedNumber.replaceAll(RegExp(r'\D'), '');

    // "0"으로 시작하지 않는 번호에 "0" 추가
    if (!cleanedNumber.startsWith('0')) {
      cleanedNumber = '0$cleanedNumber';
    }

    if (cleanedNumber.length == 11) {
      return cleanedNumber.replaceRange(3, 3, "-").replaceRange(8, 8, "-");
    } else {
      return phoneNumber;
    }
  }

  /// 문자열에서 숫자만 찾아서 반환하기.
  static String extractNumbers(String str) {
    final RegExp regExp = RegExp(r'\d');
    Iterable<Match> matches = regExp.allMatches(str);
    String numbers = matches.map((m) => m.group(0)).join('');
    return numbers;
  }
}
