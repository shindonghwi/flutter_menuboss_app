import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:menuboss_common/ui/colors.dart';

import '../../utils/Common.dart';

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
