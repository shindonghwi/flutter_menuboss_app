import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/theme.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:uni_links/uni_links.dart';

AppLocalizations getString(BuildContext context) {
  return AppLocalizations.of(context);
}

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
              return ScrollConfiguration(
                behavior: AppScrollBehavior(),
                child: child!,
              );
            },
            onGenerateTitle: (context) => getString(context).appTitle,
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
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en', 'US')],
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
