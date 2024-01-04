import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/ui/Strings.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

class DeviceGuide extends HookWidget {
  const DeviceGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.of(context).guideDetailDevice1Title,
            style: getTextTheme(context).b1sb.copyWith(
                  color: getColorScheme(context).colorGray900,
                  overflow: TextOverflow.visible,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            Strings.of(context).guideDetailDevice1Description,
            style: getTextTheme(context).b2m.copyWith(
                  color: getColorScheme(context).colorGray700,
                  overflow: TextOverflow.visible,
                ),
          ),
          const SizedBox(height: 20),
          Image.asset("packages/menuboss_common/assets/imgs/image_en_guide_device1.png"),
          const SizedBox(height: 32),
          Text(
            Strings.of(context).guideDetailDevice2Title,
            style: getTextTheme(context).b1sb.copyWith(
              color: getColorScheme(context).colorGray900,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            Strings.of(context).guideDetailDevice2Description,
            style: getTextTheme(context).b2m.copyWith(
              color: getColorScheme(context).colorGray700,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset("packages/menuboss_common/assets/imgs/image_en_guide_device2.png"),
          const SizedBox(height: 32),
          Text(
            Strings.of(context).guideDetailDevice3Title,
            style: getTextTheme(context).b1sb.copyWith(
              color: getColorScheme(context).colorGray900,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            Strings.of(context).guideDetailDevice3Description,
            style: getTextTheme(context).b2m.copyWith(
              color: getColorScheme(context).colorGray700,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset("packages/menuboss_common/assets/imgs/image_en_guide_device3.png"),
        ],
      ),
    );
  }
}
