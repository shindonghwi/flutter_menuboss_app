import 'package:flutter/material.dart';

/**
 * @feature: Theme 정의
 *
 * @author: 2023/02/07 5:48 PM donghwishin
 *
 * @description{
 *   Color Theme 는 System Color Theme에 따라 변경되도록 구현
 * }
 */
class AppTheme {
  AppTheme._();

  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.light(),
  );

  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(),
  );
}
