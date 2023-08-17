import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class PrimaryFilledButton extends HookWidget {
  final Widget? leftIcon;
  final String content;
  final bool isActivated;
  final Function()? onPressed;
  final double height;
  final double borderRadius;

  const PrimaryFilledButton.smallRound({
    Key? key,
    this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 100,
        height = 44,
        super(key: key);

  const PrimaryFilledButton.smallRect({
    Key? key,
    this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 10,
        height = 44,
        super(key: key);

  const PrimaryFilledButton.normalRect({
    Key? key,
    this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 10,
        height = 52,
        super(key: key);

  const PrimaryFilledButton.largeRound({
    Key? key,
    this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 100,
        height = 60,
        super(key: key);

  const PrimaryFilledButton.largeRect({
    Key? key,
    this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 10,
        height = 60,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var textColor = isActivated ? getColorScheme(context).white : getColorScheme(context).colorGray400;
    var textStyle = getTextTheme(context).b2sb.copyWith(color: textColor);

    switch (height) {
      case 52:
        textStyle = getTextTheme(context).b1sb.copyWith(color: textColor);
        break;
      case 60:
        textStyle = getTextTheme(context).s2sb.copyWith(color: textColor);
        break;
    }

    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: isActivated ? () => onPressed?.call() : null,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: getColorScheme(context).colorGray100,
          backgroundColor: isActivated ? getColorScheme(context).colorPrimary500 : getColorScheme(context).colorGray100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          elevation: 0,
          foregroundColor: getColorScheme(context).colorPrimary700,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leftIcon ?? Container(),
            Text(content, style: textStyle),
          ],
        ),
      ),
    );
  }
}
