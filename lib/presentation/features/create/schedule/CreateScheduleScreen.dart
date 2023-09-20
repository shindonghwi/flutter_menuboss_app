import 'package:flutter/material.dart';
import 'package:menuboss/presentation/components/appbar/TopBarNoneTitleIcon.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/features/create/schedule/widget/ScheduleContentItem.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import 'widget/ScheduleInputName.dart';

class CreateScheduleScreen extends StatelessWidget {
  const CreateScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: TopBarNoneTitleIcon(content: getAppLocalizations(context).create_schedule_title),
      ),
      body: Container(
        color: getColorScheme(context).white,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ScheduleInputName(
                  initTitle: "item?.name" ?? "",
                ),
                ScheduleContentItem()
              ],
            ),
          )
      ),),
    );
  }
}
