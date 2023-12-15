import 'package:flutter/material.dart';

/// @feature: TextStyle 을 정의한 파일
///
/// @author: 2023/08/16 5:49 PM donghwishin
///
/// @description{
///    color, underline 등 기능은 사용할때 custom 하여 사용한다.
/// }
const defaultTextStyle =
    TextStyle(fontFamily: 'pretendard', overflow: TextOverflow.ellipsis, letterSpacing: 0, height: 1);

extension StyleText on TextTheme {
  TextStyle get s1b => defaultTextStyle.copyWith(fontSize: 28, fontWeight: FontWeight.w700, height: 1.250);

  TextStyle get s1sb => defaultTextStyle.copyWith(fontSize: 28, fontWeight: FontWeight.w600, height: 1.250);

  TextStyle get s2b => defaultTextStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w700, height: 1.291);

  TextStyle get s2sb => defaultTextStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w600, height: 1.291);

  TextStyle get s3b => defaultTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700, height: 1.3);

  TextStyle get s3sb => defaultTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w600, height: 1.3);

  TextStyle get s3m => defaultTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w500, height: 1.3);

  TextStyle get s3r => defaultTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w400, height: 1.3);

  TextStyle get b1sb => defaultTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600, height: 1.277);

  TextStyle get b1m => defaultTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w500, height: 1.277);

  TextStyle get b1r => defaultTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w400, height: 1.277);

  TextStyle get b2sb => defaultTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600, height: 1.312);

  TextStyle get b2m => defaultTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w500, height: 1.312);

  TextStyle get b2r => defaultTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w400, height: 1.312);

  TextStyle get b3sb => defaultTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600, height: 1.357);

  TextStyle get b3m => defaultTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500, height: 1.357);

  TextStyle get b3r => defaultTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w400, height: 1.357);

  TextStyle get c1sb => defaultTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600, height: 1.333);

  TextStyle get c1m => defaultTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w500, height: 1.333);

  TextStyle get c1r => defaultTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400, height: 1.333);

  TextStyle get c2m => defaultTextStyle.copyWith(fontSize: 10, fontWeight: FontWeight.w500, height: 1.4);
}
