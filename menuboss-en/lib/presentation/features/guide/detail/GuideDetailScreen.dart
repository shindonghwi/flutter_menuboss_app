import 'package:flutter/material.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/presentation/features/guide/detail/widget/DeviceGuide.dart';
import 'package:menuboss/presentation/features/guide/detail/widget/MediaGuide.dart';
import 'package:menuboss/presentation/features/guide/detail/widget/ScheduleGuide.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';

import 'widget/PlaylistGuide.dart';

enum GuideType {
  device,
  schedule,
  playlist,
  media,
}

class GuideDetailScreen extends StatelessWidget {
  final GuideType type;

  const GuideDetailScreen({
    super.key,
    this.type = GuideType.device,
  });

  @override
  Widget build(BuildContext context) {
    String appBarTitle = getString(context).guideListTitle;
    Widget content = Container();

    if (type == GuideType.device) {
      appBarTitle = getString(context).guideListItemDeviceTitle;
      content = const DeviceGuide();
    } else if (type == GuideType.schedule) {
      appBarTitle = getString(context).guideListItemScheduleTitle;
      content = const ScheduleGuide();
    } else if (type == GuideType.playlist) {
      appBarTitle = getString(context).guideListItemPlaylistTitle;
      content = const PlaylistGuide();
    } else if (type == GuideType.media) {
      appBarTitle = getString(context).guideListItemMediaTitle;
      content = const MediaGuide();
    }

    return BaseScaffold(
      appBar: TopBarIconTitleNone(
        content: appBarTitle,
        onBack: () => popPageWrapper(context: context),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: content,
      ),
    );
  }
}
