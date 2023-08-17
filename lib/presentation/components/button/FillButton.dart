import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class FillButton extends HookWidget {
  final Widget? leftIcon;
  final String content;
  final bool isActivated;
  final Function()? onPressed;
  final double height;
  final double borderRadius;

  const FillButton({
    Key? key,
    required this.content,
    required this.isActivated,
    this.leftIcon,
    this.onPressed,
    this.height = 0,
    this.borderRadius = 0,
  }) : super(key: key);

  const FillButton.smallRound({
    Key? key,
    this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 100,
        height = 44,
        super(key: key);

  const FillButton.smallRect({
    Key? key,
    this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 10,
        height = 44,
        super(key: key);

  const FillButton.normalRect({
    Key? key,
    this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 10,
        height = 52,
        super(key: key);

  const FillButton.largeRound({
    Key? key,
    this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 100,
        height = 60,
        super(key: key);

  const FillButton.largeRect({
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

    var textStyle = getTextTheme(context).b2sb.copyWith(color: getColorScheme(context).white);

    switch(height){
      case 52:
        textStyle = getTextTheme(context).b1sb.copyWith(color: getColorScheme(context).white);
        break;
      case 60:
        textStyle = getTextTheme(context).s2sb.copyWith(color: getColorScheme(context).white);
        break;
    }

    return SizedBox(
      width: getMediaQuery(context).size.width,
      child: ElevatedButton(
        onPressed: isActivated ? () => onPressed?.call() : null,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: getColorScheme(context).colorGray100,
          backgroundColor: isActivated ? getColorScheme(context).colorPrimary500 : getColorScheme(context).colorGray100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leftIcon ?? Container(),
              Text(content, style: textStyle),
            ],
          ),
        ),
      ),
    );
  }
}
