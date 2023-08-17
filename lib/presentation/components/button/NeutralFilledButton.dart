import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class NeutralFilledButton extends HookWidget {
  final Widget? leftIcon;
  final String content;
  final bool isActivated;
  final Function()? onPressed;
  final double height;
  final double borderRadius;

  const NeutralFilledButton({
    Key? key,
    required this.content,
    required this.isActivated,
    this.leftIcon,
    this.onPressed,
    this.height = 0,
    this.borderRadius = 0,
  }) : super(key: key);

  const NeutralFilledButton.smallRect({
    Key? key,
    this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 10,
        height = 44,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var textColor = isActivated ? getColorScheme(context).colorGray900 : getColorScheme(context).colorGray400;
    var textStyle = getTextTheme(context).b2sb.copyWith(color: textColor);

    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: isActivated ? () => onPressed?.call() : null,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: getColorScheme(context).colorGray100,
          backgroundColor: isActivated ? getColorScheme(context).colorGray50 : getColorScheme(context).colorGray100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          elevation: 0,
          foregroundColor: getColorScheme(context).colorGray100,
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
