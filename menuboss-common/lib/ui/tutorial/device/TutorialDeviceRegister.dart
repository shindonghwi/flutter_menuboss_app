import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

import '../../../components/button/PrimaryFilledButton.dart';
import '../../../components/loader/LoadSvg.dart';
import '../../Strings.dart';

class TutorialDeviceRegister extends HookWidget {
  final VoidCallback onPressed;

  const TutorialDeviceRegister({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isKr = Localizations.localeOf(context).languageCode.contains("ko");

    return Stack(
      children: [
        Container(
          color: getColorScheme(context).black.withOpacity(0.7),
        ),
        SafeArea(
          child: Clickable(
            onPressed: () => onPressed.call(),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: isKr
                        ? Platform.isIOS
                            ? 12
                            : 14
                        : 14,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 60,
                          height: 60,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "\n",
                          style: getTextTheme(context).b3m.copyWith(
                                color: getColorScheme(context).colorGray400,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        IgnorePointer(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 32,
                                    ),
                                    PrimaryFilledButton.mediumRound100Icon(
                                      leftIcon: LoadSvg(
                                        path: "assets/imgs/icon_plus_1.svg",
                                        width: 20,
                                        height: 20,
                                        color: getColorScheme(context).white,
                                      ),
                                      content: Strings.of(context).blankMessageContentAddScreen,
                                      isActivated: true,
                                      onPressed: () {},
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Container(
                                      width: 20,
                                      height: 44,
                                      margin: const EdgeInsets.only(top: 12),
                                      child: Transform.rotate(
                                        angle: 3.14,
                                        child: LoadSvg(
                                          width: 20,
                                          height: 44,
                                          path: "assets/imgs/icon_tutorial_arrow.svg",
                                          color: getColorScheme(context).white,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            Strings.of(context).tutorialScreenAddNew,
                            style: getTextTheme(context).b3m.copyWith(
                                  color: getColorScheme(context).white,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
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
