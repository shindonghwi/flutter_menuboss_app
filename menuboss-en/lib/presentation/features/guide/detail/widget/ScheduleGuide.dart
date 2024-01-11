import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/ui/Strings.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

class ScheduleGuide extends HookWidget {
  const ScheduleGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.of(context).guideDetailSchedule1Title,
            style: getTextTheme(context).b2sb.copyWith(
              color: getColorScheme(context).colorGray900,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            Strings.of(context).guideDetailSchedule1Description,
            style: getTextTheme(context).b3m.copyWith(
              color: getColorScheme(context).colorGray700,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset("packages/menuboss_common/assets/imgs/image_en_guide_schedule1.png"),
          const SizedBox(height: 12),
          Text(
            Strings.of(context).guideDetailSchedule1SubDescription1,
            style: getTextTheme(context).c1m.copyWith(
              color: getColorScheme(context).colorGray500,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            Strings.of(context).guideDetailSchedule2Title,
            style: getTextTheme(context).b2sb.copyWith(
              color: getColorScheme(context).colorGray900,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            Strings.of(context).guideDetailSchedule2Description,
            style: getTextTheme(context).b3m.copyWith(
              color: getColorScheme(context).colorGray700,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset("packages/menuboss_common/assets/imgs/image_en_guide_schedule2.png"),
          const SizedBox(height: 32),
          Text(
            Strings.of(context).guideDetailSchedule3Title,
            style: getTextTheme(context).b2sb.copyWith(
              color: getColorScheme(context).colorGray900,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            Strings.of(context).guideDetailSchedule3Description,
            style: getTextTheme(context).b3m.copyWith(
              color: getColorScheme(context).colorGray700,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset("packages/menuboss_common/assets/imgs/image_en_guide_schedule3.png"),
        ],
      ),
    );
  }
}
