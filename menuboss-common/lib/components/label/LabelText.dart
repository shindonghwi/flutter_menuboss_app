import 'package:flutter/material.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';

import '../../utils/Common.dart';

class LabelText extends StatelessWidget {
  final String content;
  final bool isOn;

  const LabelText({
    super.key,
    required this.content,
    required this.isOn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isOn ? getColorScheme(context).colorGreen400 : getColorScheme(context).colorGray400,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        content,
        style: getTextTheme(context).c1sb.copyWith(
              color: isOn ? getColorScheme(context).white : getColorScheme(context).colorGray200,
            ),
      ),
    );
  }
}
