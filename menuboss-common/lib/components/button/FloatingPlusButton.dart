import 'package:flutter/material.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/ui/colors.dart';

import '../../../utils/Common.dart';
import '../utils/Clickable.dart';

class FloatingPlusButton extends StatelessWidget {
  final double size;
  final bool isShadowMode;
  final VoidCallback onPressed;

  const FloatingPlusButton({
    super.key,
    this.size = 60,
    this.isShadowMode = true,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: getColorScheme(context).colorPrimary500,
        shape: BoxShape.circle,
        boxShadow: isShadowMode
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.20),
                  blurRadius: 8,
                  offset: const Offset(4, 0),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.20),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Clickable(
        onPressed: () => onPressed.call(),
        borderRadius: 100,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: LoadSvg(
            path: "assets/imgs/icon_plus_1.svg",
            width: 32,
            height: 32,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
