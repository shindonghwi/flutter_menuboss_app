import 'package:flutter/material.dart';
import 'package:menuboss/presentation/features/apply_screen/ApplyToScreen.dart';
import 'package:menuboss/presentation/features/login/LoginScreen.dart';
import 'package:menuboss/presentation/features/main/MainScreen.dart';
import 'package:menuboss/presentation/features/main/my/profile/MyProfileScreen.dart';
import 'package:menuboss/presentation/features/media_info/MediaInformationScreen.dart';
import 'package:menuboss/presentation/features/scan_qr/ScanQrScreen.dart';
import 'package:menuboss/presentation/features/splash/SplashScreen.dart';

enum RoutingScreen {
  Splash(route: "/splash"), // 스플래시
  Login(route: "/login"), // 로그인
  Main(route: "/main"), // 메인

  ScanQR(route: "/scan/qr"), // Scan QR 코드 인식
  InfoMedia(route: "/info/media"), // 미디어 정보

  ApplyScreen(route: "/apply/screen"), // 스크린에 적용
  MyProfile(route: "/my/profile"); // 프로필 정보

  final String route;

  const RoutingScreen({
    required this.route,
  });

  static Map<String, WidgetBuilder> getAppRoutes() {
    return {
      RoutingScreen.Splash.route: (context) => const SplashScreen(),
      RoutingScreen.Login.route: (context) => const LoginScreen(),
      RoutingScreen.Main.route: (context) => const MainScreen(),
      RoutingScreen.ScanQR.route: (context) => const ScanQrScreen(),
      RoutingScreen.InfoMedia.route: (context) => const MediaInformationScreen(),
      RoutingScreen.ApplyScreen.route: (context) => const ApplyToScreen(),
      RoutingScreen.MyProfile.route: (context) => const MyProfileScreen(),
    };
  }

  static getScreen(String route, {dynamic parameter}) {
    if (route == RoutingScreen.Splash.route) {
      return const SplashScreen();
    } else if (route == RoutingScreen.Login.route) {
      return const LoginScreen();
    } else if (route == RoutingScreen.Main.route) {
      return const MainScreen();
    } else if (route == RoutingScreen.ScanQR.route) {
      return const ScanQrScreen();
    } else if (route == RoutingScreen.InfoMedia.route) {
      return const MediaInformationScreen();
    } else if (route == RoutingScreen.ApplyScreen.route) {
      return const ApplyToScreen();
    } else if (route == RoutingScreen.MyProfile.route) {
      return const MyProfileScreen();
    } else {
      return const SplashScreen();
    }
  }
}
