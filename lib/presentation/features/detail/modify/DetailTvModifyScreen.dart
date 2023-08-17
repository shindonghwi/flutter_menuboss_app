import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/Clickable/Clickable.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleIcon.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleText.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class DetailTvModifyScreen extends StatelessWidget {
  const DetailTvModifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorScheme(context).white,
      appBar: TopBarIconTitleText(
        content: getAppLocalizations(context).detail_tv_modify_appbar_title,
        rightTextActivated: true,
        rightIconOnPressed: () {},
        rightText: getAppLocalizations(context).common_save,
      ),
      body: SafeArea(
        child: Column(
          children: [
          ],
        ),
      ),
    );
  }
}
