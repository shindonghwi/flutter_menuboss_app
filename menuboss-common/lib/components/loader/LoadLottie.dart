import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadLottie extends StatelessWidget {
  final String path;
  final double width;
  final double height;
  final BoxFit fit;

  const LoadLottie({
    super.key,
    required this.path,
    this.width = 48,
    this.height = 48,
    this.fit = BoxFit.fill,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      "packages/menuboss_common/$path",
      width: width,
      height: height,
      fit: fit,
    );
  }
}
