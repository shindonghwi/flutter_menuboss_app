import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/button/NeutralOutlineButton.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

class ScheduleModeContent extends StatelessWidget {
  const ScheduleModeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      Pair("Basic Exposure", "00:00 ~ 00:24"),
      Pair("Morning", "06:00 ~ 12:00"),
      Pair("Lunch", "12:00 ~ 18:00"),
      Pair("Dinner", "18:00 ~ 24:00"),
      Pair("Dawn", "00:00 ~ 06:00"),
    ];

    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 24, bottom: 120),
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  width: double.infinity,
                  height: 1,
                  color: getColorScheme(context).colorGray200,
                ); // Adjust the height as needed
              },
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: AspectRatio(
                    aspectRatio: 342 / 223,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 28.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                item.first,
                                style: getTextTheme(context).s2b.copyWith(
                                      color: getColorScheme(context).colorGray900,
                                    ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Basic Exposure",
                                    style: getTextTheme(context).b2m.copyWith(
                                          color: getColorScheme(context).colorGray900,
                                        ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      "Schedule Time : ${item.second}",
                                      style: getTextTheme(context).c1m.copyWith(
                                            color: getColorScheme(context).colorGray900,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  NeutralOutlineButton.xSmallRect(
                                    content: getAppLocalizations(context).common_edit,
                                    leftIcon: Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: SvgPicture.asset(
                                        "assets/imgs/icon_image.svg",
                                        width: 18,
                                        height: 18,
                                        colorFilter: ColorFilter.mode(
                                          getColorScheme(context).colorGray900,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                    isActivated: true,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        nextSlideScreen(RoutingScreen.ScreenList.route),
                                      );
                                    },
                                  ),

                                  /// Edit만 보이게 할거면 아래를 지우면 됨.
                                  const SizedBox(width: 8),
                                  NeutralOutlineButton.xSmallRect(
                                    content: getAppLocalizations(context).common_time,
                                    leftIcon: Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: SvgPicture.asset(
                                        "assets/imgs/icon_time.svg",
                                        width: 18,
                                        height: 18,
                                        colorFilter: ColorFilter.mode(
                                          getColorScheme(context).colorGray900,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                    isActivated: true,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        // Expanded(
                        //   child: AspectRatio(
                        //     aspectRatio: 140 / 175,
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10),
                        //         color: getColorScheme(context).colorGray100,
                        //       ),
                        //       child: FittedBox(
                        //         fit: BoxFit.scaleDown,
                        //         child: Image.asset(
                        //           "assets/imgs/image_default.png",
                        //           width: 64,
                        //           height: 32,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: items.length,
            ),
          ),
        ],
      ),
    );
  }
}
