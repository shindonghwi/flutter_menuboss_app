import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';

import '../../../utils/Common.dart';

class PrimaryFilledButton extends HookWidget {
  final Widget? leftIcon;
  final String content;
  final bool isActivated;
  final Function()? onPressed;
  final int height;
  final double borderRadius;

  /// @feature: xSmall buttons
  /// @author: 2023/09/05 3:13 PM donghwishin
  const PrimaryFilledButton.xSmallRound4Icon({
    Key? key,
    required this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 4,
        height = 32,
        super(key: key);

  /// @feature: xmall buttons
  /// @author: 2023/09/05 3:13 PM donghwishin
  const PrimaryFilledButton.smallRound4({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 4,
        height = 40,
        super(key: key);

  const PrimaryFilledButton.smallRound4Icon({
    Key? key,
    required this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 4,
        height = 40,
        super(key: key);

  const PrimaryFilledButton.smallRound100({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 100,
        height = 40,
        super(key: key);

  /// @feature: small buttons
  /// @author: 2023/09/05 3:13 PM donghwishin
  const PrimaryFilledButton.mediumRound8({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 8,
        height = 48,
        super(key: key);

  const PrimaryFilledButton.mediumRound8Icon({
    Key? key,
    required this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 8,
        height = 48,
        super(key: key);

  const PrimaryFilledButton.mediumRound100({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 100,
        height = 48,
        super(key: key);

  const PrimaryFilledButton.mediumRound100Icon({
    Key? key,
    required this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 100,
        height = 48,
        super(key: key);

  /// @feature: normal buttons
  /// @author: 2023/09/05 3:13 PM donghwishin
  const PrimaryFilledButton.largeRound8({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 8,
        height = 52,
        super(key: key);

  const PrimaryFilledButton.largeRound8Icon({
    Key? key,
    required this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 8,
        height = 52,
        super(key: key);

  const PrimaryFilledButton.largeRound100({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 100,
        height = 52,
        super(key: key);

  const PrimaryFilledButton.largeRound100Icon({
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
  const PrimaryFilledButton.extraLargeRound100({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 100,
        height = 56,
        super(key: key);

  const PrimaryFilledButton.extraLargeRound100Icon({
    Key? key,
    required this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 100,
        height = 56,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var textColor = isActivated ? getColorScheme(context).white : getColorScheme(context).colorGray400;
    var textStyle = getTextTheme(context).b2sb.copyWith(color: textColor);

    switch (height) {
      case 32:
        textStyle = getTextTheme(context).c1m.copyWith(color: textColor);
        break;
      case 40:
        textStyle = getTextTheme(context).b3m.copyWith(color: textColor);
        break;
      case 48:
        textStyle = getTextTheme(context).b3m.copyWith(color: textColor);
        break;
      case 52:
        textStyle = getTextTheme(context).b2m.copyWith(color: textColor);
        break;
      case 56:
        textStyle = getTextTheme(context).b1m.copyWith(color: textColor);
        break;
    }

    return SizedBox(
      height: height.toDouble(),
      child: ElevatedButton(
        onPressed: isActivated ? () => onPressed?.call() : null,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: getColorScheme(context).colorGray200,
          backgroundColor: isActivated ? getColorScheme(context).colorPrimary500 : getColorScheme(context).colorGray200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
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
