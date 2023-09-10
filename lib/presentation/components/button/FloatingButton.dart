import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class FloatingPlusButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FloatingPlusButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: getColorScheme(context).colorPrimary500,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: getColorScheme(context).colorPrimary200,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Clickable(
        onPressed: () => onPressed.call(),
        borderRadius: 100,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: SvgPicture.asset(
            "assets/imgs/icon_plus.svg",
            width: 32,
            height: 32,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
