import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/navigation/Route.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutingScreen.Login.route,
          (route) => false,
        );
      });
      return null;
    }, []);

    return Scaffold(
      backgroundColor: const Color(0xFF482409),
      body: Center(
        child: SvgPicture.asset(
          "assets/imgs/splash_logo.svg",
          width: 128,
          height: 64,
        ),
      ),
    );
  }
}
