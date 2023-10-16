import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/presentation/ui/theme.dart';

AppLocalizations getAppLocalizations(BuildContext context) {
  return AppLocalizations.of(context);
}

TextTheme getTextTheme(BuildContext context) {
  return Theme.of(context).textTheme;
}

ColorScheme getColorScheme(BuildContext context) {
  return getMediaQuery(context).platformBrightness == Brightness.dark
      ? AppTheme.darkTheme.colorScheme
      : AppTheme.lightTheme.colorScheme;
}

MediaQueryData getMediaQuery(BuildContext context) {
  return MediaQuery.of(context);
}

///
///
/// domain, data layer 에서 di 사용하기 위해서 생성한 클래스

class AppLocalization {
  AppLocalization();

  AppLocalizations get() {
    final context = MenuBossGlobalVariable.navigatorKey.currentContext as BuildContext;
    return getAppLocalizations(context);
  }
}
