import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class BasicBorderCheckBox extends StatelessWidget {
  final String label;
  final bool isChecked;
  final double borderRadius;
  final Function(bool)? onChange;

  const BasicBorderCheckBox({
    super.key,
    this.label = "",
    this.borderRadius = 100,
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isChecked
              ? Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: getColorScheme(context).colorPrimary500,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SvgPicture.asset(
                        "assets/imgs/icon_check_line.svg",
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          getColorScheme(context).white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: getColorScheme(context).colorGray300,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
          if (label.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                label,
                style: getTextTheme(context).b1sb.copyWith(
                      color: getColorScheme(context).black,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
