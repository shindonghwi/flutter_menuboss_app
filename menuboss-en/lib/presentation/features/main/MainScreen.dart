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
import 'package:menuboss_common/ui/tutorial/device/TutorialDeviceRegister1.dart';
import 'package:menuboss_common/ui/tutorial/model/TutorialKey.dart';
import 'package:menuboss_common/ui/tutorial/playlist/TutorialPlaylistRegister1.dart';
import 'package:menuboss_common/ui/tutorial/schedule/TutorialScheduleRegister1.dart';
import 'package:menuboss_common/utils/dto/Triple.dart';

import 'devices/DevicesScreen.dart';
import 'devices/provider/DeviceListProvider.dart';
import 'media/MediaScreen.dart';
import 'my/MyScreen.dart';
import 'playlists/PlaylistsScreens.dart';
import 'playlists/provider/PlaylistProvider.dart';
import 'schedules/SchedulesScreen.dart';
import 'schedules/provider/SchedulesProvider.dart';

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
      Triple(
          'assets/imgs/icon_my_line.svg', 'assets/imgs/icon_my_filled.svg', Strings.of(context).mainNavigationMenuMy),
    ];

    final showTutorial = useState<bool>(true);
    final tutorialOpacity = useState(1.0);
    final executedCodeForIndex = useState<List<bool>>(List.generate(iconList.length, (index) => false));

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
              ref.read(schedulesProvider.notifier).requestGetSchedules();
              break;
            case 1:
              ref.read(playListProvider.notifier).requestGetPlaylists();
              break;
            case 2:
              ref.read(deviceListProvider.notifier).requestGetDevices();
              break;
            case 3:
              ref.read(mediaListProvider.notifier).requestGetMedias();
              break;
            case 4:
              break;
          }

          tutorialOpacity.value = 1.0;
          showTutorial.value = true;

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
        if (showTutorial.value)
          AnimatedOpacity(
            opacity: tutorialOpacity.value,
            duration: const Duration(milliseconds: 300),
            child: TutorialView(
              currentIndex: currentIndex,
              onTutorialClosed: () {
                tutorialOpacity.value = 0.0;
                Future.delayed(const Duration(milliseconds: 300)).then((_) => showTutorial.value = false);
              },
            ),
          ),
      ],
    );
  }
}

class TutorialView extends HookWidget {
  final int currentIndex;
  final VoidCallback onTutorialClosed;

  const TutorialView({
    super.key,
    required this.currentIndex,
    required this.onTutorialClosed,
  });

  @override
  Widget build(BuildContext context) {
    Future<Widget> tutorialView() async {
      final getTutorialViewedUseCase = GetIt.instance<GetTutorialViewedUseCase>();
      final postTutorialViewedUseCase = GetIt.instance<PostTutorialViewedUseCase>();

      if (currentIndex == 2) {
        bool hasViewed = await getTutorialViewedUseCase.call(TutorialKey.ScreenRegisterKey);
        if (!hasViewed) {
          return TutorialDeviceRegister1(onPressed: () {
            postTutorialViewedUseCase.call(TutorialKey.ScreenRegisterKey);
            onTutorialClosed.call();
          });
        }
      } else if (currentIndex == 1) {
        bool hasViewed = await getTutorialViewedUseCase.call(TutorialKey.PlaylistRegisterKey);
        if (!hasViewed) {
          return TutorialPlaylistRegister1(onPressed: () {
            postTutorialViewedUseCase.call(TutorialKey.PlaylistRegisterKey);
            onTutorialClosed.call();
          });
        }
      } else if (currentIndex == 0) {
        bool hasViewed = await getTutorialViewedUseCase.call(TutorialKey.ScheduleRegisterKey);
        if (!hasViewed) {
          return TutorialScheduleRegister1(onPressed: () {
            postTutorialViewedUseCase.call(TutorialKey.ScheduleRegisterKey);
            onTutorialClosed.call();
          });
        }
      }

      return Container();
    }

    final tutorialViewFuture = useFuture(useMemoized(() => tutorialView(), [currentIndex]));
    return tutorialViewFuture.data ?? Container();
  }
}
