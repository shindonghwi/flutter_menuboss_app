import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUIBackground,
      body: Center(
        child: Image.asset(
          "assets/imgs/logo_splash.png",
          width: 55,
          height: 66,
        ),
      ),
    );
  }
}
