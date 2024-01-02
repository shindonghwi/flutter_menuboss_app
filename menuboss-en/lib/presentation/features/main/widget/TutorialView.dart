import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:menuboss/domain/usecases/local/app/GetTutorialViewedUseCase.dart';
import 'package:menuboss/domain/usecases/local/app/PostTutorialViewedUseCase.dart';
import 'package:menuboss_common/ui/tutorial/device/TutorialDeviceAdded.dart';
import 'package:menuboss_common/ui/tutorial/device/TutorialDeviceRegister.dart';
import 'package:menuboss_common/ui/tutorial/media/TutorialMediaRegister.dart';
import 'package:menuboss_common/ui/tutorial/model/TutorialKey.dart';
import 'package:menuboss_common/ui/tutorial/playlist/TutorialPlaylistAdded.dart';
import 'package:menuboss_common/ui/tutorial/playlist/TutorialPlaylistRegister.dart';
import 'package:menuboss_common/ui/tutorial/schedule/TutorialScheduleAdded.dart';
import 'package:menuboss_common/ui/tutorial/schedule/TutorialScheduleRegister.dart';

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
        switch (tutorialKey) {
          case TutorialKey.ScreenRegisterKey:
            bool hasViewed = await getTutorialViewedUseCase.call(TutorialKey.ScreenRegisterKey);
            if (!hasViewed) {
              return TutorialDeviceRegister(
                onPressed: () {
                  onTutorialClosed.call();
                  postTutorialViewedUseCase.call(TutorialKey.ScreenRegisterKey);
                },
              );
            }
            break;
          case TutorialKey.PlaylistRegisterKey:
            bool hasViewed = await getTutorialViewedUseCase.call(TutorialKey.PlaylistRegisterKey);
            if (!hasViewed) {
              return TutorialPlaylistRegister(
                onPressed: () {
                  onTutorialClosed.call();
                  postTutorialViewedUseCase.call(TutorialKey.PlaylistRegisterKey);
                },
              );
            }
            break;
          case TutorialKey.ScheduleRegisterKey:
            bool hasViewed = await getTutorialViewedUseCase.call(TutorialKey.ScheduleRegisterKey);
            if (!hasViewed) {
              return TutorialScheduleRegister(
                onPressed: () {
                  onTutorialClosed.call();
                  postTutorialViewedUseCase.call(TutorialKey.ScheduleRegisterKey);
                },
              );
            }
            break;
          case TutorialKey.MediaRegisterKey:
            bool hasViewed = await getTutorialViewedUseCase.call(TutorialKey.MediaRegisterKey);
            if (!hasViewed) {
              return TutorialMediaRegister(
                onPressed: () {
                  onTutorialClosed.call();
                  postTutorialViewedUseCase.call(TutorialKey.MediaRegisterKey);
                },
              );
            }
            break;
          case TutorialKey.ScreenAdded:
            bool hasViewed = await getTutorialViewedUseCase.call(TutorialKey.ScreenAdded);
            if (!hasViewed) {
              return TutorialDeviceAdded(
                onPressed: () {
                  onTutorialClosed.call();
                  postTutorialViewedUseCase.call(TutorialKey.ScreenAdded);
                },
              );
            }
            break;
          case TutorialKey.PlaylistAddedKey:
            bool hasViewed = await getTutorialViewedUseCase.call(TutorialKey.PlaylistAddedKey);
            if (!hasViewed) {
              return TutorialPlaylistAdded(
                onPressed: () {
                  onTutorialClosed.call();
                  postTutorialViewedUseCase.call(TutorialKey.PlaylistAddedKey);
                },
              );
            }
            break;
          case TutorialKey.ScheduleAddedKey:
            bool hasViewed = await getTutorialViewedUseCase.call(TutorialKey.ScheduleAddedKey);
            if (!hasViewed) {
              return TutorialScheduleAdded(
                onPressed: () {
                  onTutorialClosed.call();
                  postTutorialViewedUseCase.call(TutorialKey.ScheduleAddedKey);
                },
              );
            }
            break;
          case TutorialKey.MediaAddedKey:
            bool hasViewed = await getTutorialViewedUseCase.call(TutorialKey.MediaAddedKey);
            if (!hasViewed) {
              return TutorialMediaRegister(
                onPressed: () {
                  onTutorialClosed.call();
                  postTutorialViewedUseCase.call(TutorialKey.MediaAddedKey);
                },
              );
            }
            break;
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
