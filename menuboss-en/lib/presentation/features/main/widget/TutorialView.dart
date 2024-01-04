import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:menuboss/domain/usecases/local/app/GetTutorialViewedUseCase.dart';
import 'package:menuboss/domain/usecases/local/app/PostTutorialViewedUseCase.dart';
import 'package:menuboss_common/ui/tutorial/device/TutorialDeviceAdded.dart';
import 'package:menuboss_common/ui/tutorial/media/TutorialMediaAdded.dart';
import 'package:menuboss_common/ui/tutorial/model/TutorialKey.dart';
import 'package:menuboss_common/ui/tutorial/playlist/TutorialPlaylistAdded.dart';
import 'package:menuboss_common/ui/tutorial/playlist/TutorialPlaylistMake.dart';
import 'package:menuboss_common/ui/tutorial/schedule/TutorialScheduleAdded.dart';
import 'package:menuboss_common/ui/tutorial/schedule/TutorialScheduleMake.dart';

class TutorialView extends HookWidget {
  final TutorialKey? tutorialKey;
  final VoidCallback onTutorialClosed;

  const TutorialView({
    super.key,
    required this.tutorialKey,
    required this.onTutorialClosed,
  });

  @override
  Widget build(BuildContext context) {
    Future<Widget> tutorialView() async {
      final getTutorialViewedUseCase = GetIt.instance<GetTutorialViewedUseCase>();
      final postTutorialViewedUseCase = GetIt.instance<PostTutorialViewedUseCase>();

      if (tutorialKey != null) {
        bool hasViewed = await getTutorialViewedUseCase.call(tutorialKey!);
        if (hasViewed) {
          return Container();
        }
        switch (tutorialKey) {
          case TutorialKey.ScreenAdded:
            return TutorialDeviceAdded(
              onPressed: () {
                onTutorialClosed.call();
                postTutorialViewedUseCase.call(TutorialKey.ScreenAdded);
              },
            );
          case TutorialKey.PlaylistAddedKey:
            return TutorialPlaylistAdded(
              onPressed: () {
                onTutorialClosed.call();
                postTutorialViewedUseCase.call(TutorialKey.PlaylistAddedKey);
              },
            );
          case TutorialKey.PlaylistMakeKey:
            return TutorialPlaylistMake(
              onPressed: () {
                onTutorialClosed.call();
                postTutorialViewedUseCase.call(TutorialKey.PlaylistMakeKey);
              },
            );
          case TutorialKey.ScheduleAddedKey:
            return TutorialScheduleAdded(
              onPressed: () {
                onTutorialClosed.call();
                postTutorialViewedUseCase.call(TutorialKey.ScheduleAddedKey);
              },
            );
          case TutorialKey.ScheduleMakeKey:
            return TutorialScheduleMake(
              onPressed: () {
                onTutorialClosed.call();
                postTutorialViewedUseCase.call(TutorialKey.ScheduleMakeKey);
              },
            );
          case TutorialKey.MediaAddedKey:
            return TutorialMediaAdded(
              onPressed: () async {
                onTutorialClosed.call();
                postTutorialViewedUseCase.call(TutorialKey.MediaAddedKey);
              },
            );
          default:
            break;
        }
      }
      return Container();
    }

    final tutorialViewFuture = useFuture(useMemoized(() => tutorialView(), [tutorialKey]));
    return tutorialViewFuture.data ?? Container();
  }
}
