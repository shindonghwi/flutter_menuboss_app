import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:menuboss_common/components/button/FloatingPlusButton.dart';
import 'package:menuboss_common/components/loader/LoadImage.dart';
import 'package:menuboss_common/components/placeholder/PlaceholderType.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

import '../../../components/button/PrimaryLineButton.dart';
import '../../../components/loader/LoadSvg.dart';

class TutorialPlaylistAdded extends HookWidget {
  final VoidCallback onPressed;

  const TutorialPlaylistAdded({
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
                      Text(
                        isKr ? "재생목록 이름" : "Playlist Name",
                        style: getTextTheme(context).b2m.copyWith(
                              color: getColorScheme(context).colorGray900,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          "${isKr ? "수정일" : "Updated"} : $date",
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
                              isKr ? "콘텐츠 6개" : "6 pages",
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
                  content: isKr ? "TV 적용" : "Apply",
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
              padding: const EdgeInsets.only(left: 28),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    isKr
                        ? "연결할 재생목록의 [TV 적용] 버튼을 누르고\n켜져있는 TV를 선택하면, TV와 재생목록 연결 완료!"
                        : "Press the [Apply] button to select the screen\nthat is turned on. Screen and playlist connected!",
                    style: getTextTheme(context).b3m.copyWith(
                          color: getColorScheme(context).white,
                        ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  SizedBox(
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
    bool isKr = Localizations.localeOf(context).languageCode.contains("ko");

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
                  isKr
                      ? "[+] 버튼을 눌러 새 재생목록을 만들 수 있습니다"
                      : "Press the [Plus] button to add a new playlist",
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
                        margin: const EdgeInsets.only(right: 12, bottom: 30),
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
