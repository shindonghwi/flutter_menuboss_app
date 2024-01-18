import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleText.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';

class MyBusinessScreen extends HookWidget {
  const MyBusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: TopBarIconTitleText(
        content: getString(context).myBusinessAppbarTitle,
        rightText: getString(context).commonSave,
        rightIconOnPressed: () {},
        rightTextActivated: true,
        onBack: () => popPageWrapper(context: context),
      ),
      body: Container(),
    );
  }
}
