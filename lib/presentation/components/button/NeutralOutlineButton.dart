import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class NeutralOutlineButton extends HookWidget {
  final Widget leftIcon;
  final String content;
  final bool isActivated;
  final Function()? onPressed;
  final double height;
  final double borderRadius;

  const NeutralOutlineButton.xSmallRect({
    Key? key,
    required this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 10,
        height = 36,
        super(key: key);

  const NeutralOutlineButton.smallRect({
    Key? key,
    required this.leftIcon,
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
      child: OutlinedButton(
        onPressed: isActivated ? () => onPressed?.call() : null,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: getColorScheme(context).colorGray200),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          backgroundColor: isActivated ? getColorScheme(context).white : getColorScheme(context).colorGray400,
          disabledBackgroundColor: getColorScheme(context).colorGray400,
          elevation: 0,
          foregroundColor: getColorScheme(context).colorGray200,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leftIcon,
            Text(content, style: textStyle),
          ],
        ),
      ),
    );
  }
}
