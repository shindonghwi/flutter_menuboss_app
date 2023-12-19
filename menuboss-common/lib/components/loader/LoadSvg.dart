import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss_common/ui/colors.dart';

import '../../utils/Common.dart';

class LoadSvg extends StatelessWidget {
  final String path;
  final double width;
  final double height;
  final Color? color;
  final BlendMode? blendMode;
  final BoxFit fit;

  const LoadSvg({
    super.key,
    required this.path,
    this.width = 24,
    this.height = 24,
    this.color,
    this.blendMode = BlendMode.srcIn,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "packages/menuboss_common/$path",
      width: width,
      height: height,
      colorFilter: color != null ? ColorFilter.mode(color!, blendMode!) : null,
      fit: fit,
    );
  }
}
