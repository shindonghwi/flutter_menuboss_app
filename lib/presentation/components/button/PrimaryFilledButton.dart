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

  /// @feature: xSmall buttons
  /// @author: 2023/09/05 3:13 PM donghwishin
  const PrimaryFilledButton.xSmallRound5({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 5,
        height = 36,
        super(key: key);

  const PrimaryFilledButton.xSmallRound5Icon({
    Key? key,
    required this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 5,
        height = 36,
        super(key: key);

  const PrimaryFilledButton.xSmallRound100({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 100,
        height = 36,
        super(key: key);

  /// @feature: small buttons
  /// @author: 2023/09/05 3:13 PM donghwishin
  const PrimaryFilledButton.smallRound10({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 10,
        height = 44,
        super(key: key);

  const PrimaryFilledButton.smallRound100({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 100,
        height = 44,
        super(key: key);

  const PrimaryFilledButton.smallRound100Icon({
    Key? key,
    required this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 100,
        height = 44,
        super(key: key);

  /// @feature: normal buttons
  /// @author: 2023/09/05 3:13 PM donghwishin
  const PrimaryFilledButton.normalRound10({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 10,
        height = 52,
        super(key: key);

  const PrimaryFilledButton.normalRound100Icon({
    Key? key,
    required this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 100,
        height = 52,
        super(key: key);

  /// @feature: large buttons
  /// @author: 2023/09/05 3:13 PM donghwishin
  const PrimaryFilledButton.largeRound100({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 100,
        height = 60,
        super(key: key);

  const PrimaryFilledButton.largeRound100Icon({
    Key? key,
    required this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 100,
        height = 60,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var textColor = isActivated ? getColorScheme(context).white : getColorScheme(context).colorGray400;
    var textStyle = getTextTheme(context).b2sb.copyWith(color: textColor);

    switch (height) {
      case 36:
        textStyle = getTextTheme(context).b2sb.copyWith(color: textColor);
        break;
      case 44:
        textStyle = getTextTheme(context).b2sb.copyWith(color: textColor);
        break;
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
          disabledBackgroundColor: getColorScheme(context).colorGray200,
          backgroundColor: isActivated ? getColorScheme(context).colorPrimary500 : getColorScheme(context).colorGray200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          elevation: 0,
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
