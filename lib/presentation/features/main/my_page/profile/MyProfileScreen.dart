import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/Clickable/Clickable.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleText.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarIconTitleText(
        content: getAppLocalizations(context).my_page_profile_appbar_title,
        rightText: getAppLocalizations(context).common_save,
        rightIconOnPressed: () {},
        rightTextActivated: true,
      ),
      backgroundColor: getColorScheme(context).white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 24),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: getColorScheme(context).colorGray100,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Image.asset(
                            "assets/imgs/image_default.png",
                            width: 60,
                            height: 30,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Clickable(
                          onPressed: () {},
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: getColorScheme(context).colorGray500,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: SvgPicture.asset(
                                "assets/imgs/icon_camera.svg",
                                width: 18,
                                height: 18,
                                colorFilter: ColorFilter.mode(
                                  getColorScheme(context).white,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
