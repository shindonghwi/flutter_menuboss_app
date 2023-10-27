import 'dart:async';
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
import 'package:uni_links/uni_links.dart';

final firebaseAuth = FirebaseAuth.instance;

class MenuBossApp extends HookWidget {
  const MenuBossApp({super.key});

  @override
  Widget build(BuildContext context) {
    final initialLinkFuture = useMemoized(() => getInitialLink(), []);

    final initialLink = useFuture(initialLinkFuture);

    useEffect(() {
      void handleDeepLink(String? link) {
        debugPrint("@##@@##@#####44 link : $link");
        if (link == null) return;
        if (link == "menuboss://login") {
          MenuBossGlobalVariable.navigatorKey.currentState?.pushNamed(RoutingScreen.SignUp.route);
        }
      }

      if (initialLink.hasData) {
        handleDeepLink(initialLink.data);
      }

      StreamSubscription subscription;

      subscription = uriLinkStream.listen((Uri? link) {
        debugPrint("@##@@##@ link : $link");
        handleDeepLink(link?.toString());
      }, onError: (err) {});
      return () => subscription.cancel();
    }, [initialLink]);

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

class AppScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
