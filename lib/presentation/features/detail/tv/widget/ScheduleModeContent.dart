import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
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
              padding: const EdgeInsets.only(top: 24, bottom: 40),
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  width: double.infinity,
                  height: 1,
                  color: Color(0xFFE1E1E1),
                ); // Adjust the height as needed
              },
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 174,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        margin: const EdgeInsets.only(right: 28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item.first),
                            Padding(
                              padding: const EdgeInsets.only(top: 24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Basic Menu Screen"),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text("Schedule Time : ${item.second}"),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                // Flexible(
                                //   flex: 1,
                                //   fit: FlexFit.tight,
                                //   child: PrimaryFilledButton.round(
                                //     content: Text("Edit"),
                                //     isActivated: true,
                                //     onPressed: () {
                                //       Navigator.push(
                                //         context,
                                //         nextSlideScreen(RoutingScreen.ScreenList.route),
                                //       );
                                //     },
                                //   ),
                                // ),

                                /// Edit만 보이게 할거면 아래를 지우면 됨.
                                SizedBox(width: 12),
                                // Flexible(
                                //   flex: 1,
                                //   fit: FlexFit.tight,
                                //   child: PrimaryFilledButton.round(content: Text("Edit"), isActivated: true),
                                // ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/imgs/image_default.svg",
                            width: 140,
                            height: 180,
                            fit: BoxFit.contain, // 이미지를 영역에 꽉 채우도록 설정
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: items.length,
            ),
          ),
          _ApplyButton(),
        ],
      ),
    );
  }
}

class _ApplyButton extends StatelessWidget {
  const _ApplyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24, left: 24, right: 24),
      // child: PrimaryFilledButton.round(
      //   content: Padding(
      //     padding: EdgeInsets.symmetric(vertical: 20.0),
      //     child: Text("Apply"),
      //   ),
      //   isActivated: true,
      // ),
    );
  }
}
