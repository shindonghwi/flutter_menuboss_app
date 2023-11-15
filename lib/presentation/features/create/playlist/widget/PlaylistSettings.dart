import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/button/NeutralLineButton.dart';
import 'package:menuboss/presentation/components/checkbox/radio/BasicBorderRadioButton.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/components/utils/ClickableScale.dart';
import 'package:menuboss/presentation/features/media_content/provider/MediaContentsCartProvider.dart';
import 'package:menuboss/presentation/features/preview/provider/PreviewListProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../provider/PlaylistSaveInfoProvider.dart';
import '../provider/CreatePreviewItemProcessProvider.dart';

class PlaylistSettings extends HookWidget {
  final PlaylistSettingType direction;
  final PlaylistSettingType scale;

  const PlaylistSettings({
    super.key,
    required this.direction,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    final directionType = useState(direction);
    final scaleType = useState(scale);
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
                  getAppLocalizations(context).common_option,
                  style: getTextTheme(context).b3b.copyWith(
                        color: getColorScheme(context).colorGray900,
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
    final createPreviewProcessState = ref.watch(createPreviewItemProcessProvider);
    final createPreviewProcessManager = ref.read(createPreviewItemProcessProvider.notifier);
    final previewListManager = ref.read(previewListProvider.notifier);
    final mediaCartManager = ref.read(mediaContentsCartProvider.notifier);
    final saveState = ref.watch(playlistSaveInfoProvider);
    final saveManager = ref.read(playlistSaveInfoProvider.notifier);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          createPreviewProcessState.when(
            success: (event) {
              final convertedItems = event.value;
              if (CollectionUtil.isNullorEmpty(convertedItems)) {
                Toast.showWarning(context, getAppLocalizations(context).message_add_media_content);
                return;
              }
              previewListManager.changeItems(
                PreviewModel(
                  getPlaylistDirectionTypeFromString(saveState.property.direction),
                  getPlaylistScaleTypeFromString(saveState.property.fill),
                  convertedItems,
                  convertedItems.map((e) => e.property?.duration?.toInt()).toList(),
                ),
              );

              Navigator.push(
                context,
                nextSlideVerticalScreen(
                  RoutingScreen.PreviewPlaylist.route,
                ),
              );
            },
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [createPreviewProcessState]);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          SizedBox(
            height: 96,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 45,
                  fit: FlexFit.tight,
                  child: Column(
                    children: [
                      _SettingSelectableIcon(
                        iconPath: "assets/imgs/icon_horizontal_line.svg",
                        iconText: getAppLocalizations(context).common_horizontal,
                        onPressed: () {
                          saveManager.changeDirection(PlaylistSettingType.Horizontal);
                          directionType.value = PlaylistSettingType.Horizontal;
                        },
                        isChecked: directionType.value == PlaylistSettingType.Horizontal,
                      ),
                      _SettingSelectableIcon(
                        iconPath: "assets/imgs/icon_vertical_line.svg",
                        iconText: getAppLocalizations(context).common_vertical,
                        onPressed: () {
                          saveManager.changeDirection(PlaylistSettingType.Vertical);
                          directionType.value = PlaylistSettingType.Vertical;
                        },
                        isChecked: directionType.value == PlaylistSettingType.Vertical,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  flex: 9,
                  child: Container(
                    width: 1,
                    height: 96,
                    color: getColorScheme(context).colorGray300,
                  ),
                ),
                Flexible(
                  flex: 45,
                  fit: FlexFit.tight,
                  child: Column(
                    children: [
                      _SettingSelectableIcon(
                        iconPath: "assets/imgs/icon_fill_line.svg",
                        iconText: getAppLocalizations(context).common_fill,
                        onPressed: () {
                          saveManager.changeFill(PlaylistSettingType.Fill);
                          scaleType.value = PlaylistSettingType.Fill;
                        },
                        isChecked: scaleType.value == PlaylistSettingType.Fill,
                      ),
                      _SettingSelectableIcon(
                        iconPath: "assets/imgs/icon_fit.svg",
                        iconText: getAppLocalizations(context).common_fit,
                        onPressed: () {
                          saveManager.changeFill(PlaylistSettingType.Fit);
                          scaleType.value = PlaylistSettingType.Fit;
                        },
                        isChecked: scaleType.value == PlaylistSettingType.Fit,
                      ),
                      _SettingSelectableIcon(
                        iconPath: "assets/imgs/icon_stretch.svg",
                        iconText: getAppLocalizations(context).common_stretch,
                        onPressed: () {
                          saveManager.changeFill(PlaylistSettingType.Stretch);
                          scaleType.value = PlaylistSettingType.Stretch;
                        },
                        isChecked: scaleType.value == PlaylistSettingType.Stretch,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: NeutralLineButton.extraSmallRound4Icon(
              leftIcon: SvgPicture.asset(
                "assets/imgs/icon_playlists_line.svg",
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  getColorScheme(context).black,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () async {
                var previewItems = mediaCartManager.getItems();

                createPreviewProcessManager.conversionStart(
                  scaleType.value,
                  previewItems,
                );
                // 이후 conversionStart가 끝나면 변환된 리스트를 uistate Success에서 관찰 후 이후 프리뷰로 이동한다.
              },
              content: getAppLocalizations(context).common_preview,
              isActivated: true,
            ),
          ),
          const SizedBox(
            width: 12,
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
                width: 20,
                height: 20,
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
