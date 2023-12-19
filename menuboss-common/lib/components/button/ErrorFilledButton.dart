import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';

import '../../../utils/Common.dart';

class ErrorFilledButton extends HookWidget {
  final Widget? leftIcon;
  final String content;
  final bool isActivated;
  final Function()? onPressed;
  final int height;
  final double borderRadius;

  /// @feature: medium buttons
  /// @author: 2023/09/05 3:13 PM donghwishin
  const ErrorFilledButton.mediumRound8({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 8,
        height = 48,
        super(key: key);

  const ErrorFilledButton.mediumRound100({
    Key? key,
    required this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 100,
        height = 48,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var textColor = isActivated ? getColorScheme(context).white : getColorScheme(context).colorGray400;
    var textStyle = getTextTheme(context).b3m.copyWith(color: textColor);

    switch (height) {
      case 48:
        textStyle = getTextTheme(context).b3m.copyWith(color: textColor);
        break;
    }

    return SizedBox(
      height: height.toDouble(),
      child: ElevatedButton(
        onPressed: isActivated ? () => onPressed?.call() : null,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: getColorScheme(context).colorGray200,
          backgroundColor: isActivated ? getColorScheme(context).colorRed500 : getColorScheme(context).colorGray200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          elevation: 0,
          foregroundColor: getColorScheme(context).white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leftIcon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: leftIcon,
              ),
            Text(content, style: textStyle),
          ],
        ),
      ),
    );
  }
}
