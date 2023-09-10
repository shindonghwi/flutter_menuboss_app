import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/components/checkbox/checkbox/BasicBorderCheckBox.dart';
import 'package:menuboss/presentation/components/label/LabelText.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class ApplyScreenItem extends HookWidget {
  const ApplyScreenItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          BasicBorderCheckBox(isChecked: true, onChange: (value) {}),
          const SizedBox(width: 16),
          const ImagePlaceholder(type: ImagePlaceholderType.Normal),
          const SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const LabelText(
                    content: "On",
                    isOn: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      "New Screen",
                      style: getTextTheme(context).b2sb.copyWith(
                            color: getColorScheme(context).colorGray900,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                "Schedule name",
                style: getTextTheme(context).b3m.copyWith(
                      color: getColorScheme(context).colorGray500,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
