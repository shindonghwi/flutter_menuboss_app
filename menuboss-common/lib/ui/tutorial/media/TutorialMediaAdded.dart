import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/components/button/FloatingPlusButton.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/ui/Strings.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

import '../../../components/commons/MoreButton.dart';
import '../../../components/loader/LoadSvg.dart';

class TutorialMediaAdded extends HookWidget {
  final VoidCallback onPressed;

  const TutorialMediaAdded({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isKr = Localizations.localeOf(context).languageCode.contains("ko");

    return Stack(
      children: [
        const _BackgroundContents(),
        Container(color: getColorScheme(context).black.withOpacity(0.7)),
        _EnableContents(isKr: isKr),
        SafeArea(
          child: Clickable(
            onPressed: () => onPressed.call(),
            child: const IgnorePointer(
              child: Stack(
                children: [
                  _TopContent(),
                  _BottomContent(),
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 96.0),
        child: Column(
          children: [
            const SizedBox(height: 92),
            _Content(
              fileName: isKr ? "파일 이름" : "File name",
              description: isKr ? "이미지 - 2.8MB" : "Image - 2.8MB",
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 25,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.centerRight,
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
                  flex: 75,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: DefaultTextStyle(
                        style: getTextTheme(context).b3m.copyWith(
                              color: getColorScheme(context).white,
                              overflow: TextOverflow.visible,
                            ),
                        child: Text(Strings.of(context).tutorialMediaDescription6),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
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
      child: Padding(
        padding: const EdgeInsets.only(top: 96.0, bottom: 78),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Content(
              fileName: isKr ? "새 폴더" : "New folder",
              description: isKr ? "2개 파일(4.7MB)" : "2 files(4.7MB)",
            ),
            _Content(
              fileName: isKr ? "파일 이름" : "File name",
              description: isKr ? "이미지 - 2.8MB" : "Image - 2.8MB",
            ),
            _Content(
              fileName: isKr ? "파일 이름" : "New folder",
              description: isKr ? "비디오 - 12MB" : "Video - 12MB",
            ),
            Expanded(
              child: Container(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Content extends HookWidget {
  final String fileName;
  final String description;

  const _Content({
    super.key,
    required this.fileName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      height: 92,
      color: getColorScheme(context).white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                const SizedBox(
                  width: 60,
                  height: 60,
                  child: LoadSvg(
                    path: "assets/imgs/icon_folder.svg",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: DefaultTextStyle(
                          style: getTextTheme(context).b2m.copyWith(
                                color: getColorScheme(context).colorGray900,
                              ),
                          child: Text(fileName),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: DefaultTextStyle(
                          style: getTextTheme(context).b3r.copyWith(
                                color: getColorScheme(context).colorGray500,
                              ),
                          child: Text(description),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          MoreButton(
            items: const [],
            onSelected: (type, text) => null,
          ),
        ],
      ),
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
                  Strings.of(context).tutorialMediaDescription3,
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

class _TopContent extends StatelessWidget {
  const _TopContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 12, top: 5, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform.flip(
                      child: Transform.rotate(
                        angle: -30 * math.pi / 180,
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
                      padding: const EdgeInsets.only(right: 14),
                      child: Text(
                        Strings.of(context).tutorialMediaDescription1,
                        style: getTextTheme(context).b3m.copyWith(
                              color: getColorScheme(context).white,
                            ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: getColorScheme(context).white,
                ),
                padding: const EdgeInsets.all(6),
                child: LoadSvg(
                  path: "assets/imgs/icon_new_folder.svg",
                  width: 24,
                  height: 24,
                  color: getColorScheme(context).colorGray900,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: getColorScheme(context).white,
                ),
                padding: const EdgeInsets.all(6),
                child: LoadSvg(
                  path: "assets/imgs/icon_check_round.svg",
                  width: 24,
                  height: 24,
                  color: getColorScheme(context).colorGray900,
                ),
              ),
              const SizedBox(width: 18),
            ],
          ),
        ),
        Container(
          height: 32,
          margin: const EdgeInsets.only(right: 24),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    Strings.of(context).tutorialMediaDescription2,
                    style: getTextTheme(context).b3m.copyWith(
                          color: getColorScheme(context).white,
                        ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Transform.flip(
                    flipY: true,
                    child: Transform.rotate(
                      angle: 45 * math.pi / 180,
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
            ],
          ),
        ),
      ],
    );
  }
}
