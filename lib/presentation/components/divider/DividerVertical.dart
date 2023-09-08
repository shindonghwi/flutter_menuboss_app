import 'package:flutter/material.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class DividerVertical extends StatelessWidget {
  final double marginVertical;
  final double? height;
  final Color? dividerColor;

  const DividerVertical({
    super.key,
    required this.marginVertical,
    this.height = 8,
    this.dividerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: marginVertical),
      width: double.infinity,
      color: dividerColor ?? getColorScheme(context).colorGray100,
      height: height,
    );
  }
}
