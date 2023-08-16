import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/Clickable/Clickable.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorScheme(context).colorBrown500,
      body: Clickable(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutingScreen.Login.route,
            (route) => false,
          );
        },
        child: Center(
          child: SvgPicture.asset(
            "assets/imgs/splash_logo.svg",
            width: 128,
            height: 64,
          ),
        ),
      ),
    );
  }
}
