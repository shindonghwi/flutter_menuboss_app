import 'package:flutter/material.dart';
import 'package:menuboss_common/ui/colors.dart';

import '../../../utils/Common.dart';

class BasicBorderRadioButton extends StatelessWidget {
  final bool isChecked;
  final Function(bool)? onChange;

  const BasicBorderRadioButton({
    super.key,
    required this.isChecked,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    void toggleCheckbox() {
      onChange?.call(!isChecked);
    }

    return GestureDetector(
      onTap: toggleCheckbox,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            decoration: BoxDecoration(
              border: Border.all(
                color: isChecked ? getColorScheme(context).colorPrimary500 : getColorScheme(context).colorGray300,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: isChecked
                ? Center(
                    child: Container(
                      width: constraints.maxWidth * 0.75,
                      height: constraints.maxHeight * 0.75,
                      decoration: BoxDecoration(
                        color: getColorScheme(context).colorPrimary500,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  )
                : Container(),
          );
        },
      ),
    );
  }
}
