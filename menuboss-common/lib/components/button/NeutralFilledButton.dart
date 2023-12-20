import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';

import '../../../utils/Common.dart';

class NeutralFilledButton extends HookWidget {
  final Widget? leftIcon;
  final String content;
  final bool isActivated;
  final Function()? onPressed;
  final int height;
  final double borderRadius;

  /// @feature: extra small buttons
  /// @author: 2023/09/05 3:13 PM donghwishin
  const NeutralFilledButton.extraSmallRound4({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 4,
        height = 40,
        super(key: key);

  const NeutralFilledButton.extraSmallRound100({
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
  const NeutralFilledButton.mediumRound8({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 8,
        height = 48,
        super(key: key);

  const NeutralFilledButton.mediumRound100({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : leftIcon = null,
        borderRadius = 100,
        height = 48,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var textColor = isActivated ? getColorScheme(context).colorGray900 : getColorScheme(context).colorGray400;
    var textStyle = getTextTheme(context).b3sb.copyWith(color: textColor);

    switch (height) {
      case 40:
        textStyle = getTextTheme(context).b3m.copyWith(color: textColor);
        break;
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
          backgroundColor: isActivated ? getColorScheme(context).colorGray100 : getColorScheme(context).colorGray200,
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
