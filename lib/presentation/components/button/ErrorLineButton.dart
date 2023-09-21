import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class ErrorLineButton extends HookWidget {
  final Widget? leftIcon;
  final String content;
  final bool isActivated;
  final Function()? onPressed;
  final double height;
  final double borderRadius;

  /// @feature: extraSmall buttons
  /// @author: 2023/09/05 3:13 PM donghwishin

  const ErrorLineButton.extraSmallRound4Icon({
    Key? key,
    required this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 4,
        height = 40,
        super(key: key);

  const ErrorLineButton.extraSmallRound100({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 100,
        height = 40,
        super(key: key);

  /// @feature: medium buttons
  /// @author: 2023/09/05 3:13 PM donghwishin
  const ErrorLineButton.mediumRound8({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 8,
        height = 48,
        super(key: key);

  const ErrorLineButton.mediumRound8Icon({
    Key? key,
    required this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 8,
        height = 48,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var textColor = isActivated ? getColorScheme(context).colorGray900 : getColorScheme(context).colorGray400;
    var textStyle = getTextTheme(context).b3sb.copyWith(color: textColor);

    switch (height) {
      case 40:
        textStyle = getTextTheme(context).b3sb.copyWith(color: textColor);
        break;
      case 48:
        textStyle = getTextTheme(context).b3sb.copyWith(color: textColor);
        break;
    }

    return SizedBox(
      height: height,
      child: OutlinedButton(
        onPressed: isActivated ? () => onPressed?.call() : null,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: getColorScheme(context).colorRed500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          backgroundColor: isActivated ? getColorScheme(context).white : getColorScheme(context).colorGray200,
          disabledBackgroundColor: getColorScheme(context).colorGray200,
          elevation: 0,
          foregroundColor: getColorScheme(context).colorGray500,
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
