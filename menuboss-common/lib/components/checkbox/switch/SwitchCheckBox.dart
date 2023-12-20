import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/ui/colors.dart';

import '../../../utils/Common.dart';

class SwitchCheckBox extends HookWidget {
  final bool isOn;
  final Function(bool)? onChanged;

  const SwitchCheckBox({
    Key? key,
    required this.isOn,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 100);

    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onTap: () => onChanged?.call(!isOn),
        child: AnimatedContainer(
          duration: duration,
          curve: Curves.easeIn,
          width: constraints.minWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: isOn ? getColorScheme(context).colorPrimary500 : getColorScheme(context).colorGray300,
          ),
          child: AnimatedAlign(
            duration: duration,
            alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
            curve: Curves.easeIn,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: constraints.minWidth * 0.46,
                height: constraints.minWidth * 0.46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: getColorScheme(context).white,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
