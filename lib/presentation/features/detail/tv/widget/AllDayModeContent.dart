import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/button/NeutralLineButton.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class AllDayModeContent extends StatelessWidget {
  const AllDayModeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 32, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getAppLocalizations(context).schedule_time_basic,
              style: getTextTheme(context).s2b.copyWith(
                    color: getColorScheme(context).colorGray900,
                  ),
            ),
            const SizedBox(height: 24),
            const _Content(),
          ],
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            // AspectRatio(
            //   aspectRatio: 340 / 200,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: getColorScheme(context).colorGray100,
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: FittedBox(
            //       fit: BoxFit.scaleDown,
            //       child: Image.asset(
            //         "assets/imgs/image_default.png",
            //         width: 96,
            //         height: 48,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   "Basic Menu Screen",
                  //   style: getTextTheme(context).b1m.copyWith(
                  //         color: getColorScheme(context).colorGray900,
                  //       ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      "Schedule Time : 00:00 ~ 24:00",
                      style: getTextTheme(context).c1m.copyWith(
                            color: getColorScheme(context).colorGray500,
                          ),
                    ),
                  ),
                ],
              ),
              // NeutralOutlineButton.smallRect(
              //   leftIcon: Padding(
              //     padding: const EdgeInsets.only(right: 8.0),
              //     child: SvgPicture.asset(
              //       "assets/imgs/icon_image.svg",
              //       width: 18,
              //       height: 18,
              //       colorFilter: ColorFilter.mode(
              //         getColorScheme(context).colorGray900,
              //         BlendMode.srcIn,
              //       )
              //     ),
              //   ),
              //   content: getAppLocalizations(context).common_edit,
              //   isActivated: true,
              //   onPressed: () {
              //     // Navigator.push(
              //     //   context,
              //     //   nextSlideScreen(RoutingScreen.ScreenList.route),
              //     // );
              //   },
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
