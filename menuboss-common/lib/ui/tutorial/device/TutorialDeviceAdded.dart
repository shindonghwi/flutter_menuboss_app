import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

import '../../../components/bottom_sheet/BottomSheetModifySelector.dart';
import '../../../components/commons/MoreButton.dart';
import '../../../components/label/LabelText.dart';
import '../../../components/loader/LoadImage.dart';
import '../../../components/loader/LoadSvg.dart';
import '../../../components/placeholder/PlaceholderType.dart';

class TutorialDeviceAdded extends HookWidget {
  final VoidCallback onPressed;

  const TutorialDeviceAdded({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _BottomMenuDisable(),
        Container(color: getColorScheme(context).black.withOpacity(0.7)),
        const _BottomMenuEnable(),
        SafeArea(
          child: Clickable(
            onPressed: () => onPressed.call(),
            child: IgnorePointer(
              child: Stack(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _Content(),
                      _TopDescription(),
                    ],
                  ),
                  Align(
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
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Content extends HookWidget {
  const _Content({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isKr = Localizations.localeOf(context).languageCode.contains("ko");

    return Container(
      margin: const EdgeInsets.only(top: 56),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      height: 112,
      color: getColorScheme(context).white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                const SizedBox(
                  width: 80,
                  height: 80,
                  child: LoadImage(
                    url: "",
                    type: ImagePlaceholderType.Size_80,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const LabelText(content: "On", isOn: true),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                isKr ? "TV 이름" : "Screen name",
                                style: getTextTheme(context).b2m.copyWith(
                                      color: getColorScheme(context).colorGray900,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.5),
                        child: Text(
                          isKr ? "시간표 이름" : "Schedule name",
                          style: getTextTheme(context).b3m.copyWith(
                                color: getColorScheme(context).colorGray500,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          MoreButton(
            items: const [
              ModifyType.ShowNameToScreen,
              ModifyType.Rename,
              ModifyType.Delete,
            ],
            onSelected: (type, text) => null,
          ),
        ],
      ),
    );
  }
}

class _TopDescription extends HookWidget {
  const _TopDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isKr = Localizations.localeOf(context).languageCode.contains("ko");

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 24,
            height: 12,
            margin: const EdgeInsets.only(top: 20),
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
          const SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              isKr
                  ? "TV의 On, Off 상태와 TV 화면에 연결된\n시간표, 재생목록을 살펴볼 수 있습니다"
                  : "Through On and Off of the screen\nyou can check the status of the screen",
              style: getTextTheme(context).b3m.copyWith(
                    color: getColorScheme(context).white,
                  ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomMenuDisable extends HookWidget {
  const _BottomMenuDisable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isKr = Localizations.localeOf(context).languageCode.contains("ko");

    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Container(
          width: double.infinity,
          color: getColorScheme(context).white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                height: 72,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LoadSvg(
                      path: "assets/imgs/icon_display_screen.svg",
                      width: 24,
                      height: 24,
                      color: getColorScheme(context).colorGray900,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: DefaultTextStyle(
                        style: getTextTheme(context).b2m.copyWith(
                              color: getColorScheme(context).colorGray900,
                            ),
                        child: Text(
                          isKr ? "화면 이름 표시" : "Display screen name",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24),
                height: 72,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LoadSvg(
                      path: "assets/imgs/icon_rename.svg",
                      width: 24,
                      height: 24,
                      color: getColorScheme(context).colorGray900,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: DefaultTextStyle(
                        style: getTextTheme(context).b2m.copyWith(
                              color: getColorScheme(context).colorGray900,
                            ),
                        child: Text(
                          isKr ? "이름 변경" : "Rename",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24),
                height: 72,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LoadSvg(
                      path: "assets/imgs/icon_trash.svg",
                      width: 24,
                      height: 24,
                      color: getColorScheme(context).colorGray900,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: DefaultTextStyle(
                        style: getTextTheme(context).b2m.copyWith(
                              color: getColorScheme(context).colorRed500,
                            ),
                        child: Text(
                          isKr ? "삭제" : "Delete",
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomMenuEnable extends HookWidget {
  const _BottomMenuEnable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isKr = Localizations.localeOf(context).languageCode.contains("ko");

    return Align(
      alignment: Alignment.bottomRight,
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 24,
                      height: 12,
                      margin: const EdgeInsets.only(right: 8),
                      child: Transform.flip(
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: DefaultTextStyle(
                        style: getTextTheme(context).b3m.copyWith(
                              color: getColorScheme(context).white,
                            ),
                        child: Text(
                          isKr
                              ? "자세히보기 아이콘을 눌러 [TV에 이름 표시]을 통해\nTV 화면에 이름을 표시하거나 수정 및 삭제가 가능합니다"
                              : "Display your name on the screen via the\n[More] icon or editing and deletion are possible",
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(24),
                color: getColorScheme(context).white,
                height: 72,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LoadSvg(
                      path: "assets/imgs/icon_display_screen.svg",
                      width: 24,
                      height: 24,
                      color: getColorScheme(context).colorGray900,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: DefaultTextStyle(
                        style: getTextTheme(context).b2m.copyWith(
                              color: getColorScheme(context).colorGray900,
                            ),
                        child: Text(
                          isKr ? "화면 이름 표시" : "Display screen name",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 144,
              )
            ],
          ),
        ),
      ),
    );
  }
}
