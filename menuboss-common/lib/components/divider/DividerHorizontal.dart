import 'package:flutter/material.dart';
import 'package:menuboss_common/ui/colors.dart';

import '../../utils/Common.dart';

class DividerHorizontal extends StatelessWidget {
  final double marginHorizontal;
  final double? width;
  final Color? dividerColor;

  const DividerHorizontal({
    super.key,
    required this.marginHorizontal,
    this.width = 8,
    this.dividerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: EdgeInsets.symmetric(vertical: marginHorizontal),
      color: dividerColor ?? getColorScheme(context).colorGray100,
      width: width,
    );
  }
}
