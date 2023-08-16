import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/components/Clickable/Clickable.dart';
import 'package:menuboss/presentation/components/checkbox/checkbox/BasicBorderCheckBox.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = useState(false);

    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      body: Clickable(
        onPressed: () {
          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   RoutingScreen.Login.route,
          //       (route) => false,
          // );
        },
        child: Center(
          child: BasicBorderCheckBox(
            isChecked: isChecked.value,
            onChange: (bool) {
              isChecked.value = !bool;
            },
          ),
          // child: SvgPicture.asset(
          //   "assets/imgs/splash_logo.svg",
          //   width: 128,
          //   height: 64,
          ),
      ),
    );
  }
}
