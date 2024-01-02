import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

import '../../../components/button/NeutralLineButton.dart';
import '../../../components/button/PrimaryFilledButton.dart';
import '../../../components/loader/LoadImage.dart';
import '../../../components/loader/LoadSvg.dart';
import '../../../components/placeholder/PlaceholderType.dart';
import '../../../components/textfield/OutlineTextField.dart';
import '../../Strings.dart';

class TutorialScheduleMake extends HookWidget {
  final VoidCallback onPressed;

  const TutorialScheduleMake({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _BackgroundContents(),
        Container(color: getColorScheme(context).black.withOpacity(0.7)),
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
    return SafeArea(
      child: SizedBox(
        height: getMediaQuery(context).size.height,
        child: Clickable(
          onPressed: () => onPressed.call(),
          child: IgnorePointer(
            child: Column(
              children: [
                const SizedBox(height: 56),
                SizedBox(
                  height: 110 + 43,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const _ScheduleInputName(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Container(
                              alignment: Alignment.topRight,
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Transform.flip(
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
                            ),
                          ),
                          Flexible(
                            flex: 7,
                            fit: FlexFit.tight,
                            child: Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(top: 24, left: 8),
                              child: DefaultTextStyle(
                                style: getTextTheme(context).b3m.copyWith(
                                      color: getColorScheme(context).white,
                                      overflow: TextOverflow.visible,
                                    ),
                                child: Text(Strings.of(context).tutorialScheduleDescription1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // PlaylistTotalDuration()
                    ],
                  ),
                ),
                const SizedBox(height: 70),
                Container(
                  width: 300,
                  margin: const EdgeInsets.only(left: 52, right: 20),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              Strings.of(context).tutorialScheduleDescription2,
                              style: getTextTheme(context).b3m.copyWith(
                                    color: getColorScheme(context).white,
                                    overflow: TextOverflow.visible,
                                  ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              Strings.of(context).tutorialScheduleDescription3,
                              style: getTextTheme(context).b3m.copyWith(
                                    color: getColorScheme(context).white,
                                    overflow: TextOverflow.visible,
                                  ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 64, top: 28),
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
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _ScheduleContentItem(
                  isRequired: false,
                  playListName: Strings.of(context).createScheduleDefaultPlaylistTitleMorning,
                  start: "06:00",
                  end: "11:00",
                  backgroundColor: getColorScheme(context).white,
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
    return SafeArea(
      child: SizedBox(
        height: double.infinity,
        child: Container(
          margin: const EdgeInsets.only(top: 56),
          child: Scaffold(
            bottomNavigationBar: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
              child: PrimaryFilledButton.largeRound8(
                content: Strings.of(context).commonSave,
                isActivated: true,
              ),
            ),
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 110),
                  Column(
                    children: [
                      _ScheduleContentItem(
                        isRequired: true,
                        playListName: Strings.of(context).createScheduleDefaultPlaylistTitleBasic,
                        start: "00:00",
                        end: "24:00",
                      ),
                      Container(width: double.infinity, height: 172, color: Colors.white),
                      _ScheduleContentItem(
                        isRequired: false,
                        playListName: Strings.of(context).createScheduleDefaultPlaylistTitleLunch,
                        start: "11:00",
                        end: "15:00",
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

class _ScheduleInputName extends HookWidget {
  const _ScheduleInputName({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16,
      ),
      color: getColorScheme(context).white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.of(context).commonTitle,
            style: getTextTheme(context).b3sb.copyWith(
                  color: getColorScheme(context).colorGray700,
                ),
          ),
          IgnorePointer(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: OutlineTextField.medium(
                controller: useTextEditingController(),
                hint: Strings.of(context).createScheduleTitleInput,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.text,
                showPwVisibleButton: false,
                showSuffixStatusIcon: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleContentItem extends HookWidget {
  final bool isRequired;
  final String playListName;
  final String start;
  final String end;
  final Color? backgroundColor;

  const _ScheduleContentItem({
    super.key,
    required this.isRequired,
    required this.playListName,
    required this.start,
    required this.end,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: backgroundColor ?? Colors.transparent,
      height: 172,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 24.0),
            child: const SizedBox(
              width: 140,
              height: 140,
              child: LoadImage(
                url: "",
                type: ImagePlaceholderType.Large,
              ),
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 12, right: 12, bottom: 24),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: isRequired ? 12 : 0),
                          child: Row(
                            children: [
                              if (isRequired)
                                Text(
                                  "* ",
                                  style: getTextTheme(context).s3sb.copyWith(
                                        color: getColorScheme(context).colorSecondary500,
                                      ),
                                ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: isRequired ? 16.0 : 0),
                                  child: Text(
                                    playListName,
                                    style: getTextTheme(context).s3sb.copyWith(
                                          color: getColorScheme(context).colorGray900,
                                        ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      if (!isRequired)
                        Container(
                          padding: const EdgeInsets.all(12),
                          child: LoadSvg(
                            path: "assets/imgs/icon_trash.svg",
                            width: 24.0,
                            height: 24.0,
                            color: getColorScheme(context).colorGray500,
                          ),
                        )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        start == "00:00" && end == "24:00"
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 14.5),
                                child: Text(
                                  "${Strings.of(context).commonTime} 00:00 ~ 24:00",
                                  style: getTextTheme(context).b3sb.copyWith(
                                        color: getColorScheme(context).colorGray900,
                                      ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: NeutralLineButton.smallRound4Icon(
                                    leftIcon: LoadSvg(
                                      path: "assets/imgs/icon_time_edit.svg",
                                      width: 20,
                                      height: 20,
                                      color: getColorScheme(context).colorGray900,
                                    ),
                                    content: "$start ~ $end",
                                    isActivated: true,
                                    onPressed: null,
                                  ),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: NeutralLineButton.smallRound4Icon(
                              leftIcon: LoadSvg(
                                path: "assets/imgs/icon_plus_1.svg",
                                width: 20,
                                height: 20,
                                color: getColorScheme(context).colorGray900,
                              ),
                              content: Strings.of(context).createScheduleAddPlaylist,
                              isActivated: true,
                              onPressed: null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
