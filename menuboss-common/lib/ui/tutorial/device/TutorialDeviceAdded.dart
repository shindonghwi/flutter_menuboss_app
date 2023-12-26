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
import '../../Strings.dart';

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
                      Row(
                        children: [
                          LabelText(
                            content: Strings.of(context).commonOn,
                            isOn: true,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                "Screen name",
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
                          "Schedule name",
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.topRight,
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Container(
                      width: 36,
                      height: 18,
                      margin: const EdgeInsets.only(top: 20),
                      child: Transform.rotate(
                        angle: 60 * 3.141592653589793238 / 180,
                        child: LoadSvg(
                          width: 36,
                          height: 18,
                          path: "assets/imgs/icon_tutorial_arrow1.svg",
                          color: getColorScheme(context).white,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  TextSpan(
                    text: Strings.of(context).tutorialScreenDescription1,
                    style: getTextTheme(context).b3m.copyWith(
                          color: getColorScheme(context).white,
                        ),
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                Strings.of(context).tutorialScreenDescription2,
                style: getTextTheme(context)
                    .b3m
                    .copyWith(color: getColorScheme(context).white, height: 1),
                textAlign: TextAlign.right,
              ),
            )
          ],
        ),
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
                          Strings.of(context).bottomSheetMenuDisplayShowName,
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
                          Strings.of(context).commonRename,
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
                          Strings.of(context).commonDelete,
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
    return Align(
      alignment: Alignment.bottomRight,
      child: SafeArea(
        child: SizedBox(
          width: getMediaQuery(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: getMediaQuery(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DefaultTextStyle(
                      style: getTextTheme(context)
                          .b3m
                          .copyWith(color: getColorScheme(context).white, height: 1),
                      child: Text(
                        Strings.of(context).tutorialScreenDescription3,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Container(
                              width: 36,
                              height: 18,
                              margin: const EdgeInsets.only(top: 8),
                              child: Transform.flip(
                                flipY: true,
                                child: Transform.rotate(
                                  angle: 60 * 3.141592653589793238 / 180,
                                  child: LoadSvg(
                                    width: 36,
                                    height: 18,
                                    path: "assets/imgs/icon_tutorial_arrow1.svg",
                                    color: getColorScheme(context).white,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextSpan(
                            text:
                                "                       ${Strings.of(context).tutorialScreenDescription4}",
                            style: getTextTheme(context)
                                .b3m
                                .copyWith(color: getColorScheme(context).white, height: 1),
                          ),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 24),
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
                          Strings.of(context).bottomSheetMenuDisplayShowName,
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
