import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class NeutralLineButton extends HookWidget {
  final Widget? leftIcon;
  final String content;
  final bool isActivated;
  final Function()? onPressed;
  final double height;
  final double borderRadius;

  /// @feature: extraSmall buttons
  /// @author: 2023/09/05 3:13 PM donghwishin
  const NeutralLineButton.extraSmallRound4({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 4,
        height = 40,
        super(key: key);

  const NeutralLineButton.extraSmallRound4Icon({
    Key? key,
    required this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 4,
        height = 40,
        super(key: key);

  const NeutralLineButton.extraSmallRound100({
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
  const NeutralLineButton.mediumRound8({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 8,
        height = 48,
        super(key: key);

  const NeutralLineButton.mediumRound8Icon({
    Key? key,
    required this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 8,
        height = 48,
        super(key: key);

  const NeutralLineButton.mediumRound100({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 100,
        height = 48,
        super(key: key);

  const NeutralLineButton.mediumRound100Icon({
    Key? key,
    required this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 100,
        height = 48,
        super(key: key);

  /// @feature: large buttons
  /// @author: 2023/09/05 3:13 PM donghwishin
  const NeutralLineButton.largeRound8({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 8,
        height = 52,
        super(key: key);

  const NeutralLineButton.largeRound8Icon({
    Key? key,
    required this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 8,
        height = 52,
        super(key: key);


  /// @feature: extraLarge buttons
  /// @author: 2023/09/05 3:13 PM donghwishin
  const NeutralLineButton.extraLargeRound8({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 8,
        height = 60,
        super(key: key);
  const NeutralLineButton.extraLargeRound8Icon({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 8,
        height = 60,
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
          side: BorderSide(color: getColorScheme(context).colorGray300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          backgroundColor: isActivated ? getColorScheme(context).white : getColorScheme(context).colorGray400,
          disabledBackgroundColor: getColorScheme(context).colorGray400,
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
