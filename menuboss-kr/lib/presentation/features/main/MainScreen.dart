import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/domain/usecases/local/app/GetTutorialViewedUseCase.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/features/login/provider/MeInfoProvider.dart';
import 'package:menuboss/presentation/features/main/media/provider/MediaListProvider.dart';
import 'package:menuboss_common/components/bottomNav/BottomNavBar.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/ui/tutorial/model/TutorialKey.dart';
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
import 'widget/provider/TutorialProvider.dart';

final currentIndexProvider = StateProvider<int>((ref) => 2);

class MainScreen extends HookConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meInfoManager = ref.read(meInfoProvider.notifier);
    final currentIndex = ref.watch(currentIndexProvider);
    final currentIndexManager = ref.read(currentIndexProvider.notifier);
    final tutorialState = ref.watch(tutorialProvider);
    final tutorialManager = ref.read(tutorialProvider.notifier);
    final getTutorialViewedUseCase = GetIt.instance<GetTutorialViewedUseCase>();

    List<Triple> iconList = [
      Triple('assets/imgs/icon_schedules_line.svg', 'assets/imgs/icon_schedules_filled.svg',
          getString(context).mainNavigationMenuSchedules),
      Triple('assets/imgs/icon_playlists_line.svg', 'assets/imgs/icon_playlists_filled.svg',
          getString(context).mainNavigationMenuPlaylists),
      Triple('assets/imgs/icon_screens_line.svg', 'assets/imgs/icon_screens_filled.svg',
          getString(context).mainNavigationMenuScreens),
      Triple('assets/imgs/icon_media_line.svg', 'assets/imgs/icon_media_filled.svg',
          getString(context).mainNavigationMenuMedia),
      Triple('assets/imgs/icon_my_line.svg', 'assets/imgs/icon_my_filled.svg',
          getString(context).mainNavigationMenuMy),
    ];

    final executedCodeForIndex = useState<List<bool>>(
      List.generate(iconList.length, (index) => false),
    );

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
              if (items.isNotEmpty) {
                bool hasViewed = await getTutorialViewedUseCase.call(TutorialKey.ScheduleAddedKey);
                if (!hasViewed) {
                  tutorialManager.change(TutorialKey.ScheduleAddedKey, 1.0);
                }
              }
              break;
            case 1:
              final items = await ref.read(playListProvider.notifier).requestGetPlaylists();
              if (items.isNotEmpty) {
                bool hasViewed = await getTutorialViewedUseCase.call(TutorialKey.PlaylistAddedKey);
                if (!hasViewed) {
                  tutorialManager.change(TutorialKey.PlaylistAddedKey, 1.0);
                }
              }
              break;
            case 2:
              final items = await ref.read(deviceListProvider.notifier).requestGetDevices();
              if (items.isNotEmpty) {
                bool hasViewed = await getTutorialViewedUseCase.call(TutorialKey.ScreenAdded);
                if (!hasViewed) {
                  tutorialManager.change(TutorialKey.ScreenAdded, 1.0);
                }
              }
              break;
            case 3:
              final items = await ref.read(mediaListProvider.notifier).requestGetMedias();
              if (items.isNotEmpty) {
                bool hasViewed = await getTutorialViewedUseCase.call(TutorialKey.MediaAddedKey);
                if (!hasViewed) {
                  tutorialManager.change(TutorialKey.MediaAddedKey, 1.0);
                }
              }
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
          opacity: tutorialState.second,
          duration: const Duration(milliseconds: 300),
          child: IgnorePointer(
            ignoring: tutorialState.second == 0.0,
            child: TutorialView(
              tutorialKey: tutorialState.first,
              onTutorialClosed: () => tutorialManager.change(null, 0.0),
            ),
          ),
        ),
      ],
    );
  }
}
