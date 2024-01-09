import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/data/data_source/remote/Service.dart';
import 'package:menuboss/di/locator.dart';

enum BuildType { dev, prod }

class Environment {
  const Environment._internal(this._buildType);

  final BuildType _buildType;
  static Environment _instance = const Environment._internal(BuildType.dev);

  static Environment get instance => _instance;

  static BuildType get buildType => _instance._buildType;

  static String apiUrl =
      _instance._buildType == BuildType.dev ? 'https://dev-app-api-us.menuboss.live' : 'https://app-api.themenuboss.com';

  static String webUrl =
      _instance._buildType == BuildType.dev ? 'https://dev-www-us.menuboss.live' : 'https://www.themenuboss.com/';

  static String get apiVersion => _instance._buildType == BuildType.dev ? 'v1' : 'v1'; // api Version

  factory Environment.newInstance(BuildType buildType) {
    _instance = Environment._internal(buildType);
    return _instance;
  }

  bool get isDebuggable => _buildType == BuildType.dev;

  void run() async {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light, // 혹은 Brightness.dark, 앱의 주요 배경색에 따라 선택
      statusBarIconBrightness: Brightness.dark, // 혹은 Brightness.light
    ));

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]); // 세로모드 고정

    initServiceLocator();
    Service.initializeHeaders();

    runApp(const ProviderScope(child: MenuBossApp()));
  }
}
