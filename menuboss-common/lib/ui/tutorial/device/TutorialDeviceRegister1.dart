import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/utils/Common.dart';

import '../../../components/appbar/TopBarTitle.dart';
import '../../../components/view_state/EmptyView.dart';
import '../../Strings.dart';

class TutorialDeviceRegister1 extends HookWidget {
  const TutorialDeviceRegister1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getMediaQuery(context).size.width,
      height: getMediaQuery(context).size.height,
      color: getColorScheme(context).black.withOpacity(0.7),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Expanded(
            child: Column(
              children: [
                TopBarTitle(content: Strings.of(context).mainNavigationMenuScreens),
                EmptyView(
                  type: BlankMessageType.ADD_SCREEN,
                  onPressed: () {},
                ),
              ],
            ),
          )
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   top: getMediaQuery(context).size.height * 0.5735,
          //   child: Wrap(
          //     alignment: WrapAlignment.center,
          //     children: [
          //       PrimaryFilledButton.mediumRound100Icon(
          //         leftIcon: LoadSvg(
          //           path: "assets/imgs/icon_plus_1.svg",
          //           width: 20,
          //           height: 20,
          //           color: getColorScheme(context).white,
          //         ),
          //         content: Strings.of(context).blankMessageContentAddScreen,
          //         onPressed: () {},
          //         isActivated: true,
          //       )
          //     ],
          //   ),
          // ),
          // // 아이콘 배치
          // Positioned(
          //   left: getMediaQuery(context).size.width / 2 + 65,
          //   top: getMediaQuery(context).size.height * 0.5735 + 12,
          //   child: Transform.rotate(
          //     // -180 degree
          //     angle: 3.1415926535897932,
          //     child: LoadSvg(
          //       path: "assets/imgs/icon_tutorial_arrow.svg",
          //       width: 20,
          //       height: 44,
          //       color: getColorScheme(context).white,
          //     ),
          //   ),
          // ),
          //
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   top: getMediaQuery(context).size.height * 0.5735 + 48,
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 16.0),
          //     child: Text(
          //       Strings.of(context).tutorialScreenAddNew,
          //       textAlign: TextAlign.center,
          //       style: getTextTheme(context).b3m.copyWith(
          //             color: getColorScheme(context).white,
          //           ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
