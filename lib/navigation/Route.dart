import 'package:flutter/material.dart';
import 'package:menuboss/presentation/features/splash/SplashScreen.dart';

enum RoutingScreen {
  Splash(route: "/splash"); // 스플래시

  final String route;

  const RoutingScreen({
    required this.route,
  });

  static Map<String, WidgetBuilder> getAppRoutes() {
    return {
      RoutingScreen.Splash.route: (context) => const SplashScreen(),
    };
  }

  static getScreen(String route, {dynamic parameter}) {
    switch (route) {
      case "/splash":
        return const SplashScreen();
      default:
        return const SplashScreen();
    }
  }
}
