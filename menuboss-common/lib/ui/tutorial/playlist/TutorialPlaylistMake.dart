import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

import '../../../components/button/NeutralLineButton.dart';
import '../../../components/button/PrimaryFilledButton.dart';
import '../../../components/checkbox/radio/BasicBorderRadioButton.dart';
import '../../../components/loader/LoadImage.dart';
import '../../../components/loader/LoadSvg.dart';
import '../../../components/placeholder/PlaceholderType.dart';
import '../../../components/textfield/OutlineTextField.dart';
import '../../../utils/CollectionUtil.dart';
import '../../../utils/StringUtil.dart';

class TutorialPlaylistMake extends HookWidget {
  final VoidCallback onPressed;

  const TutorialPlaylistMake({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _BackgroundContents(),
        Container(
          color: getColorScheme(context).black.withOpacity(0.7),
        ),
        _ForegroundContents(onPressed: onPressed),
      ],
    );
  }
}

class _ForegroundContents extends StatelessWidget {
  const _ForegroundContents({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isKr = Localizations.localeOf(context).languageCode.contains("ko");

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: getMediaQuery(context).size.height,
        child: Clickable(
          onPressed: () => onPressed.call(),
          child: IgnorePointer(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 56,
                  margin: const EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Transform.flip(
                        child: Transform.rotate(
                          angle: -60 * math.pi / 180,
                          child: LoadSvg(
                            width: 24,
                            height: 12,
                            path: "assets/imgs/icon_tutorial_arrow1.svg",
                            color: getColorScheme(context).white,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          isKr ? '재생목록의 제목을 입력해주세요' : 'Please write the title of the playlist',
                          style: getTextTheme(context).b3m.copyWith(
                                color: getColorScheme(context).white,
                                overflow: TextOverflow.visible,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 380,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const PlaylistInputName(),
                      const PlaylistSettings(),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Transform.flip(
                              flipY: true,
                              child: Transform.rotate(
                                angle: -60 * math.pi / 180,
                                child: LoadSvg(
                                  width: 24,
                                  height: 12,
                                  path: "assets/imgs/icon_tutorial_arrow1.svg",
                                  color: getColorScheme(context).white,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12, left: 8),
                              child: Text(
                                isKr
                                    ? '옵션에서 TV 화면의 모습을 설정할 수 있습니다'
                                    : 'Set the playlist settings in the options',
                                style: getTextTheme(context).b3m.copyWith(
                                      color: getColorScheme(context).white,
                                      overflow: TextOverflow.visible,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // PlaylistTotalDuration()
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Transform.rotate(
                              angle: -60 * math.pi / 180,
                              child: LoadSvg(
                                width: 24,
                                height: 12,
                                path: "assets/imgs/icon_tutorial_arrow1.svg",
                                color: getColorScheme(context).white,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, bottom: 12),
                              child: Text(
                                isKr
                                    ? '콘텐츠를 추가 및 정렬하고 시간 설정이 가능합니다'
                                    : 'Add and sort content, set time',
                                style: getTextTheme(context).b3m.copyWith(
                                      color: getColorScheme(context).white,
                                      overflow: TextOverflow.visible,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _PlaylistContentItem(
                      type: "image",
                      name: isKr ? "이미지 이름" : "Image name",
                      duration: 10,
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 72,
                      child: LoadSvg(
                        path: "assets/imgs/icon_tutorial_close.svg",
                        width: 36,
                        height: 36,
                        color: getColorScheme(context).white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BackgroundContents extends StatelessWidget {
  const _BackgroundContents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isKr = Localizations.localeOf(context).languageCode.contains("ko");

    return SafeArea(
      child: SizedBox(
        height: double.infinity,
        child: Container(
          margin: const EdgeInsets.only(top: 56),
          child: Scaffold(
            backgroundColor: getColorScheme(context).white,
            bottomNavigationBar: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
              child: PrimaryFilledButton.largeRound8(
                content: isKr ? '저장' : 'Save',
                isActivated: true,
              ),
            ),
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 324),
                  Column(
                    children: [
                      Container(
                        color: getColorScheme(context).white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                DefaultTextStyle(
                                  style: getTextTheme(context).b3m.copyWith(
                                        color: getColorScheme(context).colorGray900,
                                      ),
                                  child: Text(isKr ? '총 재생 시간' : 'Total duration'),
                                ),
                                SizedBox(width: 8),
                                DefaultTextStyle(
                                  style: getTextTheme(context).b3m.copyWith(
                                        color: getColorScheme(context).colorGray500,
                                      ),
                                  child: const Text("00:00:00"),
                                ),
                              ],
                            ),
                            PrimaryFilledButton.xSmallRound4Icon(
                              leftIcon: LoadSvg(
                                path: "assets/imgs/icon_plus_1.svg",
                                width: 16,
                                height: 16,
                                color: getColorScheme(context).white,
                              ),
                              content: isKr ? '콘텐츠 추가' : 'Add content',
                              isActivated: true,
                              onPressed: null,
                            ),
                          ],
                        ),
                      ),
                      _PlaylistContentItem(
                        type: "video",
                        name: isKr ? "동영상 이름" : "Video name",
                        duration: 10,
                      ),
                      Container(width: double.infinity, height: 92, color: Colors.white),
                      _PlaylistContentItem(
                        type: "canvas",
                        name: isKr ? "캔버스 이름" : "Canvas name",
                        duration: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PlaylistInputName extends HookWidget {
  const PlaylistInputName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isKr = Localizations.localeOf(context).languageCode.contains("ko");

    return Container(
      color: getColorScheme(context).white,
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(
            style: getTextTheme(context).b3sb.copyWith(
                  color: getColorScheme(context).colorGray900,
                ),
            child: Text(
              isKr ? '제목' : 'Title',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: OutlineTextField.medium(
              controller: useTextEditingController(),
              hint: isKr ? '제목을 입력해주세요' : 'Please enter a title',
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.text,
              showPwVisibleButton: false,
              showSuffixStatusIcon: false,
              onChanged: (name) => null,
            ),
          ),
        ],
      ),
    );
  }
}

class PlaylistSettings extends HookWidget {
  const PlaylistSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isFolded = useState(false);
    final isKr = Localizations.localeOf(context).languageCode.contains("ko");
    final controller = useAnimationController(duration: const Duration(milliseconds: 300));
    final rotationAnimation = Tween<double>(begin: 0, end: math.pi).animate(controller);

    return Container(
      color: getColorScheme(context).white,
      child: Column(
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
                    isKr ? '옵션' : 'Option',
                    style: getTextTheme(context).b3sb.copyWith(
                          color: getColorScheme(context).colorGray900,
                        ),
                  ),
                  AnimatedBuilder(
                    animation: rotationAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: rotationAnimation.value,
                        child: LoadSvg(
                          path: "assets/imgs/icon_down.svg",
                          width: 20,
                          height: 20,
                          color: getColorScheme(context).colorGray900,
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
            child: !isFolded.value ? const _SettingContents() : const SizedBox(height: 0),
          ),
        ],
      ),
    );
  }
}

class _SettingContents extends HookWidget {
  const _SettingContents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isKr = Localizations.localeOf(context).languageCode.contains("ko");

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
                        iconText: isKr ? '가로' : 'Horizontal',
                        onPressed: () {},
                        isChecked: true,
                      ),
                      _SettingSelectableIcon(
                        iconPath: "assets/imgs/icon_vertical_line.svg",
                        iconText: isKr ? '세로' : 'Vertical',
                        onPressed: () {},
                        isChecked: false,
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
                        iconText: isKr ? '채우기' : 'Fill',
                        onPressed: () {},
                        isChecked: true,
                      ),
                      _SettingSelectableIcon(
                        iconPath: "assets/imgs/icon_fit.svg",
                        iconText: isKr ? '맞추기' : 'Fit',
                        onPressed: () {},
                        isChecked: false,
                      ),
                      _SettingSelectableIcon(
                        iconPath: "assets/imgs/icon_stretch.svg",
                        iconText: isKr ? '늘리기' : 'Stretch',
                        onPressed: () {},
                        isChecked: false,
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
            child: NeutralLineButton.smallRound4Icon(
              leftIcon: LoadSvg(
                path: "assets/imgs/icon_playlists_line.svg",
                width: 20,
                height: 20,
                color: getColorScheme(context).black,
              ),
              onPressed: () => null,
              content: isKr ? '미리보기' : 'Preview',
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              LoadSvg(
                path: iconPath,
                width: 24,
                height: 24,
                color: getColorScheme(context).colorGray900,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  iconText,
                  style: getTextTheme(context).b3m.copyWith(
                        color: getColorScheme(context).colorGray900,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 20,
            height: 20,
            child: BasicBorderRadioButton(
              isChecked: isChecked,
              onChange: null,
            ),
          )
        ],
      ),
    );
  }
}

class _PlaylistContentItem extends HookWidget {
  final String type;
  final String name;
  final double duration;

  const _PlaylistContentItem({
    super.key,
    required this.type,
    required this.name,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    String iconWidgetPath = "";

    switch (type) {
      case "image":
        iconWidgetPath = "assets/imgs/icon_image.svg";
        break;
      case "video":
        iconWidgetPath = "assets/imgs/icon_video.svg";
        break;
      case "canvas":
        iconWidgetPath = "assets/imgs/icon_canvas.svg";
        break;
    }

    return Container(
      width: double.infinity,
      color: Colors.white,
      height: 92,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: LoadSvg(
                    path: "assets/imgs/icon_alignment.svg",
                    width: 20,
                    height: 20,
                    color: getColorScheme(context).colorGray500,
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 60,
                        height: 60,
                        child: LoadImage(
                          url: "",
                          type: ImagePlaceholderType.Size_60,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 0),
                          child: Row(
                            children: [
                              if (!CollectionUtil.isNullEmptyFromString(iconWidgetPath))
                                LoadSvg(
                                  path: iconWidgetPath,
                                  width: 16,
                                  height: 16,
                                  color: getColorScheme(context).colorGray900,
                                ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4.0, right: 12),
                                  child: DefaultTextStyle(
                                    style: getTextTheme(context).b3sb.copyWith(
                                          color: getColorScheme(context).colorGray900,
                                        ),
                                    child: Text(name),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: type == "video"
                                      ? getColorScheme(context).colorGray100
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: getColorScheme(context).colorGray300,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 8.5, vertical: 8),
                                child: DefaultTextStyle(
                                  style: getTextTheme(context).c1sb.copyWith(
                                        color: type == "video"
                                            ? getColorScheme(context).colorGray400
                                            : getColorScheme(context).colorGray900,
                                      ),
                                  child: Text(
                                    StringUtil.formatDuration(duration.toDouble()),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Clickable(
            onPressed: null,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: LoadSvg(
                path: "assets/imgs/icon_trash.svg",
                width: 20,
                height: 20,
                color: getColorScheme(context).colorGray500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
