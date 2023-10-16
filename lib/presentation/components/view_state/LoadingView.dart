import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class LoadingView extends HookWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getMediaQuery(context).size.width,
      height: getMediaQuery(context).size.height,
      child: Center(
        child: Lottie.asset(
          'assets/motions/loading.json',
          width: 48,
          height: 48,
          fit: BoxFit.fill,
        )
      ),
    );
  }
}

