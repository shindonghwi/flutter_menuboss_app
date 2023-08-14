import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class FillButton extends HookWidget {
  final Widget? content;
  final bool isActivated;
  final Function()? onPressed;
  final double borderRadius;

  const FillButton({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
    this.borderRadius = 0,
  }) : super(key: key);

  const FillButton.round({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 8,
        super(key: key);

  const FillButton.rect({
    Key? key,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getMediaQuery(context).size.width,
      child: ElevatedButton(
        onPressed: isActivated ? () => onPressed?.call() : null,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: Colors.grey,
          backgroundColor: isActivated ? Colors.blue : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
        ),
        child: content,
      ),
    );
  }
}
