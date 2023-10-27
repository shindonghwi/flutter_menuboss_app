import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/features/login/provider/LoginProvider.dart';
import 'package:menuboss/presentation/features/login/provider/MeInfoProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/dto/Triple.dart';

import 'devices/DevicesScreen.dart';
import 'devices/provider/DeviceListProvider.dart';
import 'media/MediaScreen.dart';
import 'media/provider/MediaListProvider.dart';
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

    List<Triple> iconList = [
      Triple('assets/imgs/icon_schedules_line.svg', 'assets/imgs/icon_schedules_filled.svg',
          getAppLocalizations(context).main_navigation_menu_schedules),
      Triple('assets/imgs/icon_playlists_line.svg', 'assets/imgs/icon_playlists_filled.svg',
          getAppLocalizations(context).main_navigation_menu_playlists),
      Triple('assets/imgs/icon_screens_line.svg', 'assets/imgs/icon_screens_filled.svg',
          getAppLocalizations(context).main_navigation_menu_screens),
      Triple('assets/imgs/icon_media_line.svg', 'assets/imgs/icon_media_filled.svg',
          getAppLocalizations(context).main_navigation_menu_media),
      Triple('assets/imgs/icon_my_line.svg', 'assets/imgs/icon_my_filled.svg',
          getAppLocalizations(context).main_navigation_menu_my),
    ];

    final executedCodeForIndex = useState<List<bool>>(List.generate(iconList.length, (index) => false));

    useEffect(() {
      if (!executedCodeForIndex.value[currentIndex]) {
        WidgetsBinding.instance.addPostFrameCallback((_) {

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
          executedCodeForIndex.value[currentIndex] = true;
        });
      }
      return null;
    }, [currentIndex]);

    return BaseScaffold(
      extendBody: true,
      body: Stack(
        children: [
          IndexedStack(
            index: currentIndex,
            children: const [
              SchedulesScreen(),
              PlaylistsScreens(),
              DevicesScreen(),
              MediaScreen(),
              MyScreen(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: _BottomNavigationBar(
        iconList: iconList,
      ),
    );
  }
}

class _BottomNavigationBar extends HookConsumerWidget {
  final List<Triple> iconList;

  const _BottomNavigationBar({
    required this.iconList,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    return Container(
      color: getColorScheme(context).white,
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: getColorScheme(context).colorGray400,
                    width: 0.5,
                  ),
                ),
              ),
              height: 72,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: getColorScheme(context).white,
                    selectedItemColor: getColorScheme(context).colorPrimary900,
                    unselectedItemColor: getColorScheme(context).colorGray400,
                    currentIndex: currentIndex,
                    onTap: (index) => ref.read(currentIndexProvider.notifier).state = index,
                    items: iconList.map((data) {
                      return BottomNavigationBarItem(
                        icon: Column(
                          children: [
                            SvgPicture.asset(
                              data.first,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                getColorScheme(context).colorGray400,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            )
                          ],
                        ),
                        activeIcon: Column(
                          children: [
                            SvgPicture.asset(
                              data.second,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                getColorScheme(context).colorPrimary900,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            )
                          ],
                        ),
                        label: data.third,
                      );
                    }).toList(),
                    selectedLabelStyle: getTextTheme(context).c1sb,
                    unselectedLabelStyle: getTextTheme(context).c1sb,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
