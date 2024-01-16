import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/app/MenuBossApp.dart';
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
            getString(context).guideDetailDevice1Title,
            style: getTextTheme(context).b2sb.copyWith(
                  color: getColorScheme(context).colorGray900,
                  overflow: TextOverflow.visible,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            getString(context).guideDetailDevice1Description,
            style: getTextTheme(context).b3m.copyWith(
                  color: getColorScheme(context).colorGray700,
                  overflow: TextOverflow.visible,
                ),
          ),
          const SizedBox(height: 20),
          Image.asset("packages/menuboss_common/assets/imgs/image_en_guide_device1.png"),
          const SizedBox(height: 12),
          Text(
            getString(context).guideDetailDevice1SubDescription1,
            style: getTextTheme(context).c1m.copyWith(
                  color: getColorScheme(context).colorGray500,
                  overflow: TextOverflow.visible,
                ),
          ),
          Text(
            getString(context).guideDetailDevice1SubDescription2,
            style: getTextTheme(context).c1m.copyWith(
                  color: getColorScheme(context).colorGray500,
                  overflow: TextOverflow.visible,
                ),
          ),
          const SizedBox(height: 32),
          Text(
            getString(context).guideDetailDevice2Title,
            style: getTextTheme(context).b2sb.copyWith(
                  color: getColorScheme(context).colorGray900,
                  overflow: TextOverflow.visible,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            getString(context).guideDetailDevice2Description,
            style: getTextTheme(context).b3m.copyWith(
                  color: getColorScheme(context).colorGray700,
                  overflow: TextOverflow.visible,
                ),
          ),
          const SizedBox(height: 20),
          Image.asset("packages/menuboss_common/assets/imgs/image_en_guide_device2.png"),
          const SizedBox(height: 32),
          Text(
            getString(context).guideDetailDevice3Title,
            style: getTextTheme(context).b2sb.copyWith(
                  color: getColorScheme(context).colorGray900,
                  overflow: TextOverflow.visible,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            getString(context).guideDetailDevice3Description,
            style: getTextTheme(context).b3m.copyWith(
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
