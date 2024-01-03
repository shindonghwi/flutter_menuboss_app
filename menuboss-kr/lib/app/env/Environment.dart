import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
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

  static String kakaoNativeAppKey =
      _instance._buildType == BuildType.dev ? '87e95076a7810aa93854080bab89a56f' : '782a9583e5428ca708d3feae7b536359';

  static String apiUrl =
      _instance._buildType == BuildType.dev ? 'https://dev-app-api.menuboss.kr' : 'https://app-api.menuboss.kr';

  static String webUrl =
      _instance._buildType == BuildType.dev ? 'https://dev-www.menuboss.kr' : 'https://www.menuboss.kr';

  static String get apiVersion => _instance._buildType == BuildType.dev ? 'v1' : 'v1'; // api Version

  factory Environment.newInstance(BuildType buildType) {
    _instance = Environment._internal(buildType);
    return _instance;
  }

  bool get isDebuggable => _buildType == BuildType.dev;

  void run() async {
    print('Environment run: ${await KakaoSdk.origin}');
    KakaoSdk.init(nativeAppKey: Environment.kakaoNativeAppKey);
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
