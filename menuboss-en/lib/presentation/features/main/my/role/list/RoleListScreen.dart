import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';

class RoleListScreen extends HookWidget {
  const RoleListScreen
      ({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: TopBarIconTitleNone(
        content: getString(context).roleListAppbarTitle,
        onBack: () => popPageWrapper(context: context),
      ),
      body: Container(),
    );
  }
}
