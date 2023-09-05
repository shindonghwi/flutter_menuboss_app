import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleText.dart';
import 'package:menuboss/presentation/components/textfield/OutlineTextField.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class MyProfileScreen extends HookWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: Clickable(
                    borderRadius: 50,
                    onPressed: () {},
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
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 32, bottom: 40),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InputFullName(),
                      SizedBox(height: 24),
                      _InputEmail(),
                      SizedBox(height: 24),
                      _InputBusinessName(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputFullName extends HookWidget {
  const _InputFullName({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getAppLocalizations(context).my_page_profile_full_name,
          style: getTextTheme(context).b1sb.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.small(
          controller: useTextEditingController(),
          hint: "John Doe",
        )
      ],
    );
  }
}

class _InputEmail extends HookWidget {
  const _InputEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${getAppLocalizations(context).common_email} ${getAppLocalizations(context).common_address}",
          style: getTextTheme(context).b1sb.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.small(
          controller: useTextEditingController(),
          hint: "John Doe",
          enable: false,
        )
      ],
    );
  }
}

class _InputBusinessName extends HookWidget {
  const _InputBusinessName({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getAppLocalizations(context).my_page_profile_business_name,
          style: getTextTheme(context).b1sb.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.small(
          controller: useTextEditingController(),
          hint: "Menuboss",
        )
      ],
    );
  }
}
