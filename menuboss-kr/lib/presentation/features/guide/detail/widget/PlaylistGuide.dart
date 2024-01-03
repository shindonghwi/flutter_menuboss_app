import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/ui/Strings.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

class PlaylistGuide extends HookWidget {
  const PlaylistGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.of(context).guideDetailPlaylist1Title,
            style: getTextTheme(context).b1sb.copyWith(
              color: getColorScheme(context).colorGray900,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            Strings.of(context).guideDetailPlaylist1Description,
            style: getTextTheme(context).b2m.copyWith(
              color: getColorScheme(context).colorGray700,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset("packages/menuboss_common/assets/imgs/image_kr_guide_playlist1.png"),
          const SizedBox(height: 12),
          Text(
            Strings.of(context).guideDetailPlaylist1SubDescription1,
            style: getTextTheme(context).b3m.copyWith(
              color: getColorScheme(context).colorGray500,
              overflow: TextOverflow.visible,
            ),
          ),
          Text(
            Strings.of(context).guideDetailPlaylist1SubDescription2,
            style: getTextTheme(context).b3m.copyWith(
              color: getColorScheme(context).colorGray500,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            Strings.of(context).guideDetailPlaylist2Title,
            style: getTextTheme(context).b1sb.copyWith(
              color: getColorScheme(context).colorGray900,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            Strings.of(context).guideDetailPlaylist2Description,
            style: getTextTheme(context).b2m.copyWith(
              color: getColorScheme(context).colorGray700,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset("packages/menuboss_common/assets/imgs/image_kr_guide_playlist2.png"),
          const SizedBox(height: 32),
          Text(
            Strings.of(context).guideDetailPlaylist3Title,
            style: getTextTheme(context).b1sb.copyWith(
              color: getColorScheme(context).colorGray900,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            Strings.of(context).guideDetailPlaylist3Description,
            style: getTextTheme(context).b2m.copyWith(
              color: getColorScheme(context).colorGray700,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset("packages/menuboss_common/assets/imgs/image_kr_guide_playlist3.png"),
        ],
      ),
    );
  }
}
