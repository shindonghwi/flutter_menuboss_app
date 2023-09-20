import 'package:flutter/material.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';
import 'package:menuboss/presentation/features/apply_screen/ApplyToDeviceScreen.dart';
import 'package:menuboss/presentation/features/create/playlist/CreatePlaylistScreen.dart';
import 'package:menuboss/presentation/features/create/schedule/CreateScheduleScreen.dart';
import 'package:menuboss/presentation/features/detail/playlist/DetailPlaylistScreen.dart';
import 'package:menuboss/presentation/features/login/LoginScreen.dart';
import 'package:menuboss/presentation/features/main/MainScreen.dart';
import 'package:menuboss/presentation/features/main/my/profile/MyProfileScreen.dart';
import 'package:menuboss/presentation/features/media_content/MediaContentScreen.dart';
import 'package:menuboss/presentation/features/media_info/MediaInformationScreen.dart';
import 'package:menuboss/presentation/features/preview/PreviewPlaylistScreen.dart';
import 'package:menuboss/presentation/features/scan_qr/ScanQrScreen.dart';
import 'package:menuboss/presentation/features/splash/SplashScreen.dart';

enum RoutingScreen {
  Splash(route: "/splash"), // 스플래시
  Login(route: "/login"), // 로그인
  Main(route: "/main"), // 메인

  ScanQR(route: "/scan/qr"), // Scan QR 코드 인식
  MediaInfo(route: "/media/info"), // 미디어 정보
  MediaContent(route: "/media/content"), // 미디어 콘텐츠 목록

  DetailPlaylist(route: "/detail/playlist"), // 플레이리스트 상세
  CreatePlaylist(route: "/create/playlist"), // 플레이리스트 만들기
  PreviewPlaylist(route: "/preview/playlist"), // 플레이리스트 미리보기

  CreateSchedule(route: "/create/schedule"), // 스케줄 만들기

  ApplyDevice(route: "/apply/screen"), // 스크린에 적용
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
      RoutingScreen.MediaInfo.route: (context) => const MediaInformationScreen(),
      RoutingScreen.MediaContent.route: (context) => const MediaContentScreen(),

      RoutingScreen.DetailPlaylist.route: (context) => const DetailPlaylistScreen(),
      RoutingScreen.CreatePlaylist.route: (context) => const CreatePlaylistScreen(),
      RoutingScreen.PreviewPlaylist.route: (context) => const PreviewPlaylistScreen(),

      RoutingScreen.CreateSchedule.route: (context) => const CreateScheduleScreen(),

      RoutingScreen.ApplyDevice.route: (context) => const ApplyToDeviceScreen(),
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
    }

    else if (route == RoutingScreen.ScanQR.route) {
      return const ScanQrScreen();
    } else if (route == RoutingScreen.MediaInfo.route) {
      ResponseMediaModel model = parameter;
      return MediaInformationScreen(item: model);
    } else if (route == RoutingScreen.MediaContent.route) {
      return const MediaContentScreen();
    }

    else if (route == RoutingScreen.DetailPlaylist.route) {
      ResponsePlaylistModel model = parameter;
      return DetailPlaylistScreen(item: model);
    }
    else if (route == RoutingScreen.CreatePlaylist.route) {
      ResponsePlaylistModel? model = parameter;
      return CreatePlaylistScreen(item: model);
    }
    else if (route == RoutingScreen.PreviewPlaylist.route) {
      return const PreviewPlaylistScreen();
    }

    else if (route == RoutingScreen.CreateSchedule.route) {
      return const CreateScheduleScreen();
    }

    else if (route == RoutingScreen.ApplyDevice.route) {
      return const ApplyToDeviceScreen();
    } else if (route == RoutingScreen.MyProfile.route) {
      return const MyProfileScreen();
    } else {
      return const SplashScreen();
    }
  }
}
