import 'package:flutter/material.dart';
import 'package:menuboss/presentation/features/splash/SplashScreen.dart';

import '../presentation/features/detail/modify/DetailTvModifyScreen.dart';
import '../presentation/features/detail/setting/DetailTvSettingScreen.dart';
import '../presentation/features/detail/tv/DetailTvScreen.dart';
import '../presentation/features/login/LoginScreen.dart';
import '../presentation/features/main/MainScreen.dart';

enum RoutingScreen {
  Splash(route: "/splash"), // 스플래시
  Login(route: "/login"), // 로그인
  Main(route: "/main"), // 메인
  AddTV(route: "/add/tv"), // 티비 추가하기
  DetailTv(route: "/detail/tv"), // 티비 상세
  DetailTvSetting(route: "/detail/tv/setting"), // 티비 상세 설정
  DetailTvModify(route: "/detail/tv/modify"), // 티비 정보 수정
  ListScreen(route: "/list/screen"), // 스크린 리스트
  Profile(route: "/my/profile"), // 프로필
  ProfilePlan(route: "/my/profile/plan"); // 프로필 플랜 정보

  final String route;

  const RoutingScreen({
    required this.route,
  });

  static Map<String, WidgetBuilder> getAppRoutes() {
    return {
      RoutingScreen.Splash.route: (context) => const SplashScreen(),
      RoutingScreen.Login.route: (context) => const LoginScreen(),
      RoutingScreen.Main.route: (context) => const MainScreen(),
      // RoutingScreen.AddTV.route: (context) => const SplashScreen(),
      RoutingScreen.DetailTv.route: (context) => const DetailTvScreen(),
      RoutingScreen.DetailTvSetting.route: (context) => const DetailTvSettingScreen(),
      RoutingScreen.DetailTvModify.route: (context) => const DetailTvModifyScreen(),
      // RoutingScreen.ListScreen.route: (context) => const SplashScreen(),
      // RoutingScreen.Profile.route: (context) => const SplashScreen(),
      // RoutingScreen.ProfilePlan.route: (context) => const SplashScreen(),
    };
  }

  static getScreen(String route, {dynamic parameter}) {
    if (route == RoutingScreen.Splash.route) {
      return const SplashScreen();
    } else if (route == RoutingScreen.Login.route) {
      return const LoginScreen();
    } else if (route == RoutingScreen.Main.route) {
      return const MainScreen();
    } else if (route == RoutingScreen.DetailTv.route) {
      return const DetailTvScreen();
    } else if (route == RoutingScreen.DetailTvSetting.route) {
      return const DetailTvSettingScreen();
    } else if (route == RoutingScreen.DetailTvModify.route) {
      return const DetailTvModifyScreen();
    } else {
      return const SplashScreen();
    }
  }
}
