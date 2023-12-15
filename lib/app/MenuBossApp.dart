import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/app/env/Environment.dart';
import 'package:menuboss/data/data_source/remote/HeaderKey.dart';
import 'package:menuboss/data/data_source/remote/Service.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/theme.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:uni_links/uni_links.dart';

import '../presentation/components/toast/Toast.dart';

final firebaseAuth = FirebaseAuth.instance;

class MenuBossApp extends HookWidget {
  const MenuBossApp({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration.zero, () {
          Toast.init(context);
        });
        uriLinkStream.listen((Uri? uriLink) {
          handleDeepLink(uriLink?.toString());
        });
      });
      return null;
    }, []);

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth != 0) {
          return MaterialApp(
            builder: (context, child) {
              Locale locale = Localizations.localeOf(context);
              // Environment.setApiUrl(locale.languageCode == 'ko');
              // Service.addHeader(key: HeaderKey.AcceptLanguage, value: locale.languageCode == 'ko' ? 'ko-KR' : 'en-US');
              Environment.setApiUrl(false);
              Service.addHeader(key: HeaderKey.AcceptLanguage, value: 'en-US');
              return ScrollConfiguration(
                behavior: AppScrollBehavior(),
                child: child!,
              );
            },
            onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
            theme: AppTheme.lightTheme.copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: getColorScheme(context).colorPrimary500,
                selectionColor: getColorScheme(context).colorSecondary50,
              ),
            ),
            darkTheme: AppTheme.darkTheme.copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: getColorScheme(context).colorPrimary500,
                selectionColor: getColorScheme(context).colorSecondary50,
              ),
            ),
            themeMode: ThemeMode.system,
            // supportedLocales: AppLocalizations.supportedLocales,
            supportedLocales: const [Locale('en')],
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

class AppScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
