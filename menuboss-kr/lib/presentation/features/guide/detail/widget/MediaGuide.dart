import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

class MediaGuide extends HookWidget {
  const MediaGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getString(context).guideDetailMedia1Title,
            style: getTextTheme(context).b2sb.copyWith(
              color: getColorScheme(context).colorGray900,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            getString(context).guideDetailMedia1Description,
            style: getTextTheme(context).b3m.copyWith(
              color: getColorScheme(context).colorGray700,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset("packages/menuboss_common/assets/imgs/image_kr_guide_media1.png"),
          const SizedBox(height: 12),
          Text(
            getString(context).guideDetailMedia1SubDescription1,
            style: getTextTheme(context).c1m.copyWith(
              color: getColorScheme(context).colorGray500,
              overflow: TextOverflow.visible,
            ),
          ),
          Text(
            getString(context).guideDetailMedia1SubDescription2,
            style: getTextTheme(context).c1m.copyWith(
              color: getColorScheme(context).colorGray500,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            getString(context).guideDetailMedia2Title,
            style: getTextTheme(context).b2sb.copyWith(
              color: getColorScheme(context).colorGray900,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            getString(context).guideDetailMedia2Description,
            style: getTextTheme(context).b3m.copyWith(
              color: getColorScheme(context).colorGray700,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset("packages/menuboss_common/assets/imgs/image_kr_guide_media2.png"),
          const SizedBox(height: 32),
          Text(
            getString(context).guideDetailMedia3Title,
            style: getTextTheme(context).b2sb.copyWith(
              color: getColorScheme(context).colorGray900,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            getString(context).guideDetailMedia3Description,
            style: getTextTheme(context).b3m.copyWith(
              color: getColorScheme(context).colorGray700,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset("packages/menuboss_common/assets/imgs/image_kr_guide_media3.png"),
        ],
      ),
    );
  }
}
