import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarTitle.dart';
import 'package:menuboss/presentation/components/blank/BlankMessage.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class SchedulesScreen extends HookWidget {
  const SchedulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: TopBarTitle(
        content: getAppLocalizations(context).main_navigation_menu_schedules,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: BlankMessage(
            type: BlankMessageType.NEW_SCHEDULE,
            onPressed: () async {
              try {
                final isUpdated = await Navigator.push(
                  context,
                  nextSlideVerticalScreen(
                    RoutingScreen.CreateSchedule.route,
                  ),
                );

                if (isUpdated) {
                  ToastUtil.successToast("스케줄업데이트");
                }
              } catch (e) {
                debugPrint(e.toString());
              }
            },
          ),
        ),
      ),
    );
  }
}
