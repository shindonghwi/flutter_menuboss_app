import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:menuboss/app/env/Environment.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/theme.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/navigation/Route.dart';

final firebaseAuth = FirebaseAuth.instance;

class MenuBossApp extends HookWidget {
  const MenuBossApp({super.key});

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth != 0) {
          return MaterialApp(
            // app default option
            onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,

            // 시스템 테마 설정 (라이트, 다크 모드)
            theme: AppTheme.lightTheme.copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: getColorScheme(context).colorPrimary500,
              ),
            ),
            darkTheme: AppTheme.darkTheme.copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: getColorScheme(context).colorPrimary500,
              ),
            ),
            themeMode: ThemeMode.system,

            // 앱 Localization ( 영어, 한국어 지원 )
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,

            debugShowCheckedModeBanner: true,

            initialRoute: RoutingScreen.Splash.route,
            routes: RoutingScreen.getAppRoutes(),

            navigatorKey: MenuBossGlobalVariable.navigatorKey,
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class MenuBossGlobalVariable {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
