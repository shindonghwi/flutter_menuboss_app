
import 'package:flutter/material.dart';

import '../ui/theme.dart';

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