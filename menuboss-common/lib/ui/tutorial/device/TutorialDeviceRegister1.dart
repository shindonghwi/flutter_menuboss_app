import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

import '../../../components/button/PrimaryFilledButton.dart';
import '../../../components/loader/LoadSvg.dart';
import '../../Strings.dart';

class TutorialDeviceRegister1 extends HookWidget {
  final VoidCallback onPressed;

  const TutorialDeviceRegister1({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getColorScheme(context).black.withOpacity(0.7),
      child: SafeArea(
        child: Container(
          color: getColorScheme(context).white,
          child: Clickable(
            onPressed: () => onPressed.call(),
            child: IgnorePointer(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 56),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoadSvg(
                            path: "assets/imgs/image_blank_device.svg",
                            width: 60,
                            height: 60,
                            color: getColorScheme(context).colorGray300,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            Strings.of(context).blankMessageDescriptionAddScreen,
                            style: getTextTheme(context).b3m.copyWith(
                                  color: getColorScheme(context).colorGray400,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 72,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: getColorScheme(context).black.withOpacity(0.7),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 56),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 72,
                          ),
                          Text(
                            " \n ",
                            style: getTextTheme(context).b3m.copyWith(
                                  color: getColorScheme(context).colorGray400,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: PrimaryFilledButton.mediumRound100Icon(
                              leftIcon: LoadSvg(
                                path: "assets/imgs/icon_plus_1.svg",
                                width: 20,
                                height: 20,
                                color: getColorScheme(context).white,
                              ),
                              content: Strings.of(context).blankMessageContentAddScreen,
                              isActivated: true,
                              onPressed: () => onPressed.call(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.only(top: 56, left: 142),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 72,
                          ),
                          Text(
                            " \n ",
                            style: getTextTheme(context).b3m.copyWith(
                                  color: getColorScheme(context).colorGray400,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 36),
                            child: Transform.rotate(
                              // -180 degree
                              angle: 3.14,
                              child: LoadSvg(
                                path: "assets/imgs/icon_tutorial_arrow.svg",
                                width: 20,
                                height: 44,
                                color: getColorScheme(context).white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.only(top: 56 + 48 + 36),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 72,
                          ),
                          Text(
                            " \n ",
                            style: getTextTheme(context).b3m.copyWith(
                                  color: getColorScheme(context).colorGray400,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
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
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Container(
                  //     margin: const EdgeInsets.only(top: 56),
                  //     child: Column(
                  //       mainAxisSize: MainAxisSize.min,
                  //       crossAxisAlignment: CrossAxisAlignment.end,
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         const SizedBox(
                  //           height: 72,
                  //         ),
                  //         Text(
                  //           " \n ",
                  //           style: getTextTheme(context).b3m.copyWith(
                  //                 color: getColorScheme(context).colorGray400,
                  //               ),
                  //           textAlign: TextAlign.center,
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(top: 88),
                  //           child: Text(
                  //             Strings.of(context).tutorialScreenAddNew,
                  //             style: getTextTheme(context).b3m.copyWith(
                  //               color: getColorScheme(context).colorGray400,
                  //             ),
                  //             textAlign: TextAlign.center,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
