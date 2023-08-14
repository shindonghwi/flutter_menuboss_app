import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../model/CheckBoxSize.dart';
import '../model/CheckBoxType.dart';

class BasicBorderCheckBox extends HookWidget {
  final bool isChecked;
  final CheckBoxSize size;
  final CheckBoxType type;
  final Function(bool) onChange;

  const BasicBorderCheckBox({
    Key? key,
    required bool this.isChecked,
    required this.size,
    required this.type,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: size == CheckBoxSize.Normal ? 1.33 : 1,
      child: Checkbox(
        value: isChecked,
        activeColor: Colors.red,
        fillColor: MaterialStateProperty.all(
          isChecked ? Colors.red : Colors.grey,
        ),
        checkColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            type == CheckBoxType.Circle ? 100 : 2,
          ),
        ),
        onChanged: (bool? value) => onChange(isChecked),
      ),
    );
  }
}
