import 'package:flutter/material.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';

class MyPlanScreen extends StatelessWidget {
  const MyPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      //   appBar: TopBarIconTitleText(
      //     content: getAppLocalizations(context).my_page_profile_appbar_title,
      //     rightText: getAppLocalizations(context).common_save,
      //     rightIconOnPressed: () {},
      //     rightTextActivated: true,
      //   ),
      //   backgroundColor: getColorScheme(context).white,
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
