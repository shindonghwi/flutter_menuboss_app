import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PageUtil {
  static const String krPackageName = "com.orot.menuboss.kr";
  static const String usPackageName = "com.orot.menuboss";
  static const String krIOSAppId = "6475026803";
  static const String usIOSAppId = "6467700525";

  static void moveStore(BuildContext context) {
    const baseIOSUrl = "https://apps.apple.com/app/id";
    const baseAndroidUrl = "https://play.google.com/store/apps/details?id=";

    bool isKr = Localizations.localeOf(context).languageCode == "ko";
    bool isIOS = Platform.isIOS;
    if (isKr) {
      if (isIOS) {
        launchUrlString(
          "$baseIOSUrl$krIOSAppId",
          mode: LaunchMode.externalApplication,
        );
      } else {
        launchUrlString(
          "$baseAndroidUrl$krPackageName",
          mode: LaunchMode.externalApplication,
        );
      }
    } else {
      if (isIOS) {
        launchUrlString(
          "$baseIOSUrl$usIOSAppId",
          mode: LaunchMode.externalApplication,
        );
      } else {
        launchUrlString(
          "$baseAndroidUrl$usPackageName",
          mode: LaunchMode.externalApplication,
        );
      }
    }
  }
}
