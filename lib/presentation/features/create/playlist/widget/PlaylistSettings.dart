import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/components/checkbox/radio/BasicBorderRadioButton.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/components/utils/ClickableScale.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../provider/PlaylistSettingInfoProvider/PlaylistSaveInfoProvider.dart';

class PlaylistSettings extends HookWidget {
  const PlaylistSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final directionType = useState(PlaylistSettingType.Horizontal);
    final scaleType = useState(PlaylistSettingType.Fit);
    final isFolded = useState(false);

    final controller = useAnimationController(duration: const Duration(milliseconds: 300));
    final rotationAnimation = Tween<double>(begin: 0, end: pi).animate(controller);

    return Column(
      children: [
        Clickable(
          onPressed: () {
            if (isFolded.value) {
              controller.reverse();
            } else {
              controller.forward();
            }
            isFolded.value = !isFolded.value;
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getAppLocalizations(context).common_settings,
                  style: getTextTheme(context).b3b.copyWith(
                        color: getColorScheme(context).colorGray500,
                      ),
                ),
                AnimatedBuilder(
                  animation: rotationAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: rotationAnimation.value,
                      child: SvgPicture.asset(
                        "assets/imgs/icon_down.svg",
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          getColorScheme(context).colorGray900,
                          BlendMode.srcIn,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: !isFolded.value
              ? _SettingContents(
                  directionType: directionType,
                  scaleType: scaleType,
                )
              : const SizedBox(height: 0),
        ),
      ],
    );
  }
}

class _SettingContents extends HookConsumerWidget {
  const _SettingContents({
    super.key,
    required this.directionType,
    required this.scaleType,
  });

  final ValueNotifier<PlaylistSettingType> directionType;
  final ValueNotifier<PlaylistSettingType> scaleType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saveProvider = ref.read(PlaylistSaveInfoProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 14,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                _SettingSelectableIcon(
                  iconPath: "assets/imgs/icon_horizontal_line.svg",
                  iconText: getAppLocalizations(context).common_horizontal,
                  onPressed: () {
                    saveProvider.changeDirection(PlaylistSettingType.Horizontal);
                    directionType.value = PlaylistSettingType.Horizontal;
                  },
                  isChecked: directionType.value == PlaylistSettingType.Horizontal,
                ),
                const SizedBox(height: 8),
                _SettingSelectableIcon(
                  iconPath: "assets/imgs/icon_vertical_line.svg",
                  iconText: getAppLocalizations(context).common_vertical,
                  onPressed: () {
                    saveProvider.changeDirection(PlaylistSettingType.Vertical);
                    directionType.value = PlaylistSettingType.Vertical;
                  },
                  isChecked: directionType.value == PlaylistSettingType.Vertical,
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 64,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: getColorScheme(context).colorGray300,
          ),
          Expanded(
            child: Column(
              children: [
                _SettingSelectableIcon(
                  iconPath: "assets/imgs/icon_fit.svg",
                  iconText: getAppLocalizations(context).common_fit,
                  onPressed: () {
                    saveProvider.changeDirection(PlaylistSettingType.Fit);
                    directionType.value = PlaylistSettingType.Fit;
                  },
                  isChecked: scaleType.value == PlaylistSettingType.Fit,
                ),
                const SizedBox(height: 8),
                _SettingSelectableIcon(
                  iconPath: "assets/imgs/icon_fill.svg",
                  iconText: getAppLocalizations(context).common_fill,
                  onPressed: () {
                    saveProvider.changeDirection(PlaylistSettingType.Fill);
                    directionType.value = PlaylistSettingType.Fill;
                  },
                  isChecked: scaleType.value == PlaylistSettingType.Fill,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingSelectableIcon extends HookWidget {
  final bool isChecked;
  final String iconPath;
  final String iconText;
  final VoidCallback onPressed;

  const _SettingSelectableIcon({
    super.key,
    required this.isChecked,
    required this.iconPath,
    required this.iconText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ClickableScale(
      onPressed: () => onPressed.call(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    getColorScheme(context).colorGray900,
                    BlendMode.srcIn,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    iconText,
                    style: getTextTheme(context).b3sb.copyWith(
                          color: getColorScheme(context).colorGray900,
                        ),
                  ),
                ),
              ],
            ),
            IgnorePointer(
              child: SizedBox(
                width: 24,
                height: 24,
                child: BasicBorderRadioButton(
                  isChecked: isChecked,
                  onChange: null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
