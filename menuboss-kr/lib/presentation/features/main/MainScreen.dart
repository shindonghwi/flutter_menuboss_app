import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/domain/usecases/local/app/GetTutorialViewedUseCase.dart';
import 'package:menuboss/domain/usecases/local/app/PostTutorialViewedUseCase.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/features/login/provider/MeInfoProvider.dart';
import 'package:menuboss/presentation/features/main/media/provider/MediaListProvider.dart';
import 'package:menuboss_common/components/bottomNav/BottomNavBar.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/ui/strings.dart';
import 'package:menuboss_common/ui/tutorial/device/TutorialDeviceRegister.dart';
import 'package:menuboss_common/ui/tutorial/media/TutorialMediaRegister.dart';
import 'package:menuboss_common/ui/tutorial/model/TutorialKey.dart';
import 'package:menuboss_common/ui/tutorial/playlist/TutorialPlaylistRegister.dart';
import 'package:menuboss_common/ui/tutorial/schedule/TutorialScheduleRegister.dart';
import 'package:menuboss_common/utils/dto/Triple.dart';

import 'devices/DevicesScreen.dart';
import 'devices/provider/DeviceListProvider.dart';
import 'media/MediaScreen.dart';
import 'my/MyScreen.dart';
import 'playlists/PlaylistsScreens.dart';
import 'playlists/provider/PlaylistProvider.dart';
import 'schedules/SchedulesScreen.dart';
import 'schedules/provider/SchedulesProvider.dart';
import 'widget/TutorialView.dart';

final currentIndexProvider = StateProvider<int>((ref) => 2);

class MainScreen extends HookConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meInfoManager = ref.read(meInfoProvider.notifier);
    final currentIndex = ref.watch(currentIndexProvider);
    final currentIndexManager = ref.read(currentIndexProvider.notifier);

    List<Triple> iconList = [
      Triple('assets/imgs/icon_schedules_line.svg', 'assets/imgs/icon_schedules_filled.svg',
          Strings.of(context).mainNavigationMenuSchedules),
      Triple('assets/imgs/icon_playlists_line.svg', 'assets/imgs/icon_playlists_filled.svg',
          Strings.of(context).mainNavigationMenuPlaylists),
      Triple('assets/imgs/icon_screens_line.svg', 'assets/imgs/icon_screens_filled.svg',
          Strings.of(context).mainNavigationMenuScreens),
      Triple('assets/imgs/icon_media_line.svg', 'assets/imgs/icon_media_filled.svg',
          Strings.of(context).mainNavigationMenuMedia),
      Triple('assets/imgs/icon_my_line.svg', 'assets/imgs/icon_my_filled.svg',
          Strings.of(context).mainNavigationMenuMy),
    ];

    final tutorialKey = useState<TutorialKey?>(null);
    final tutorialOpacity = useState(0.0);
    final executedCodeForIndex =
    useState<List<bool>>(List.generate(iconList.length, (index) => false));

    useEffect(() {
      if (!executedCodeForIndex.value[currentIndex]) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (meInfoManager.getMeInfo() == null) {
            Navigator.pushAndRemoveUntil(
              context,
              nextFadeInOutScreen(RoutingScreen.Login.route),
                  (route) => false,
            );
            return;
          }

          switch (currentIndex) {
            case 0:
              final items = await ref.read(schedulesProvider.notifier).requestGetSchedules();
              tutorialKey.value = items.isEmpty ? null : TutorialKey.ScheduleAddedKey;
              tutorialOpacity.value = 1.0;
              break;
            case 1:
              final items = await ref.read(playListProvider.notifier).requestGetPlaylists();
              tutorialKey.value = items.isEmpty ? null : TutorialKey.PlaylistAddedKey;
              tutorialOpacity.value = 1.0;
              break;
            case 2:
              final items = await ref.read(deviceListProvider.notifier).requestGetDevices();
              tutorialKey.value = items.isEmpty ? null : TutorialKey.ScreenAdded;
              tutorialOpacity.value = 1.0;
              break;
            case 3:
              final items = await ref.read(mediaListProvider.notifier).requestGetMedias();
              tutorialKey.value = items.isEmpty ? null : TutorialKey.MediaAddedKey;
              tutorialOpacity.value = 1.0;
              break;
            case 4:
              break;
          }

          executedCodeForIndex.value[currentIndex] = true;
        });
      }
      return null;
    }, [currentIndex]);

    return Stack(
      children: [
        BaseScaffold(
          body: IndexedStack(
            index: currentIndex,
            children: const [
              SchedulesScreen(),
              PlaylistsScreens(),
              DevicesScreen(),
              MediaScreen(),
              MyScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavBar(
            currentIndex: currentIndex,
            iconList: iconList,
            onTap: (index) => currentIndexManager.state = index,
          ),
        ),

        // 튜토리얼 화면
        AnimatedOpacity(
          opacity: tutorialOpacity.value,
          duration: const Duration(milliseconds: 300),
          child: IgnorePointer(
            ignoring: tutorialOpacity.value == 0,
            child: TutorialView(
              tutorialKey: tutorialKey.value,
              onTutorialClosed: () => tutorialOpacity.value = 0.0,
            ),
          ),
        ),
      ],
    );
  }
}
