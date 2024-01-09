import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:menuboss_common/components/button/FloatingPlusButton.dart';
import 'package:menuboss_common/components/loader/LoadImage.dart';
import 'package:menuboss_common/components/placeholder/PlaceholderType.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/ui/Strings.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

import '../../../components/button/PrimaryLineButton.dart';
import '../../../components/loader/LoadSvg.dart';

class TutorialScheduleAdded extends HookWidget {
  final VoidCallback onPressed;

  const TutorialScheduleAdded({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isKr = Localizations.localeOf(context).languageCode.contains("ko");

    return Stack(
      children: [
        SafeArea(
          child: Container(
            color: getColorScheme(context).white,
            margin: const EdgeInsets.only(top: 56, bottom: 78),
          ),
        ),
        Container(color: getColorScheme(context).black.withOpacity(0.7)),
        SafeArea(
          child: Clickable(
            onPressed: () => onPressed.call(),
            child: IgnorePointer(
              child: Stack(
                children: [
                  _EnableContents(isKr: isKr),
                  const _BottomContent(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _EnableContents extends StatelessWidget {
  const _EnableContents({
    super.key,
    required this.isKr,
  });

  final bool isKr;

  @override
  Widget build(BuildContext context) {
    final isKr = Localizations.localeOf(context).languageCode.contains("ko");
    final contentTypes = ["image", "video", "canvas"];

    final date = DateFormat(isKr ? 'yyyy/MM/dd' : 'MM/dd/yyyy').format(DateTime.now());

    return SafeArea(
      child: Column(
        children: [
          Container(
            height: 112,
            margin: const EdgeInsets.only(top: 56.0),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            color: getColorScheme(context).white,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 80,
                  height: 80,
                  child: LoadImage(
                    url: "",
                    type: ImagePlaceholderType.Normal,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isKr ? "시간표 이름" : "Schedule Name",
                        style: getTextTheme(context).b2m.copyWith(
                              color: getColorScheme(context).colorGray900,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          "${Strings.of(context).commonUpdated} : $date",
                          style: getTextTheme(context).c1m.copyWith(
                                color: getColorScheme(context).colorGray500,
                              ),
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: contentTypes.map((e) {
                              return Container(
                                margin: const EdgeInsets.only(right: 4),
                                child: _ContentTypeImage(code: e),
                              );
                            }).toList(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              Strings.of(context).count_pages(6),
                              style: getTextTheme(context).c1m.copyWith(
                                    color: getColorScheme(context).colorGray500,
                                  ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                PrimaryLineButton.smallRound100(
                  content: Strings.of(context).commonConnectScreen,
                  isActivated: true,
                  onPressed: () => null,
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 48.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: Strings.of(context).tutorialScheduleDescription4,
                          style: getTextTheme(context).b3m.copyWith(
                                color: getColorScheme(context).white,
                              ),
                        ),
                        WidgetSpan(
                          child: Container(
                            margin: const EdgeInsets.only(left: 48, bottom: 6),
                            width: 24,
                            height: 12,
                            child: Transform.rotate(
                              angle: 120 * math.pi / 180,
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
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      Strings.of(context).tutorialScheduleDescription5,
                      style: getTextTheme(context)
                          .b3m
                          .copyWith(color: getColorScheme(context).white, height: 1),
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ContentTypeImage extends StatelessWidget {
  final String code;

  const _ContentTypeImage({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    var typeCode = code.toLowerCase();
    var iconPath = "";

    switch (typeCode) {
      case "image":
        iconPath = "assets/imgs/icon_image.svg";
        break;
      case "video":
        iconPath = "assets/imgs/icon_video.svg";
        break;
      case "canvas":
        iconPath = "assets/imgs/icon_canvas.svg";
        break;
    }

    return LoadSvg(
      path: iconPath,
      width: 16,
      height: 16,
      color: getColorScheme(context).colorGray500,
    );
  }
}

class _BottomContent extends StatelessWidget {
  const _BottomContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  Strings.of(context).tutorialScheduleDescription6,
                  style: getTextTheme(context).b3m.copyWith(
                        color: getColorScheme(context).white,
                      ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 78,
                  margin: const EdgeInsets.only(right: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 7, bottom: 30),
                        child: LoadSvg(
                          width: 20,
                          height: 44,
                          path: "assets/imgs/icon_tutorial_arrow.svg",
                          color: getColorScheme(context).white,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingPlusButton(
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 72,
            child: LoadSvg(
              path: "assets/imgs/icon_tutorial_close.svg",
              width: 36,
              height: 36,
              color: getColorScheme(context).white,
            ),
          ),
        ],
      ),
    );
  }
}
