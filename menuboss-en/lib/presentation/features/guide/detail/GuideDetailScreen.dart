import 'package:flutter/material.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/presentation/features/guide/detail/widget/DeviceGuide.dart';
import 'package:menuboss/presentation/features/guide/detail/widget/MediaGuide.dart';
import 'package:menuboss/presentation/features/guide/detail/widget/ScheduleGuide.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/ui/Strings.dart';

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
    String appBarTitle = Strings.of(context).guideListTitle;
    Widget content = Container();

    if (type == GuideType.device) {
      appBarTitle = Strings.of(context).guideListItemDeviceTitle;
      content = const DeviceGuide();
    } else if (type == GuideType.schedule) {
      appBarTitle = Strings.of(context).guideListItemScheduleTitle;
      content = const ScheduleGuide();
    } else if (type == GuideType.playlist) {
      appBarTitle = Strings.of(context).guideListItemPlaylistTitle;
      content = const PlaylistGuide();
    } else if (type == GuideType.media) {
      appBarTitle = Strings.of(context).guideListItemMediaTitle;
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
