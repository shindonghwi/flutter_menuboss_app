import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

import 'devices/DevicesScreen.dart';
import 'media/MediaScreen.dart';
import 'my/MyScreen.dart';
import 'playlists/PlaylistsScreens.dart';
import 'schedules/SchedulesScreen.dart';

class MainScreen extends HookWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(2);

    List<Pair> iconList = [
      Pair('assets/imgs/icon_schedules.svg', getAppLocalizations(context).main_navigation_menu_schedules),
      Pair('assets/imgs/icon_playlists.svg', getAppLocalizations(context).main_navigation_menu_playlists),
      Pair('assets/imgs/icon_screens.svg', getAppLocalizations(context).main_navigation_menu_screens),
      Pair('assets/imgs/icon_media.svg', getAppLocalizations(context).main_navigation_menu_media),
      Pair('assets/imgs/icon_my.svg', getAppLocalizations(context).main_navigation_menu_my),
    ];

    return BaseScaffold(
      extendBody: true,
      body: Stack(
        children: [
          IndexedStack(
            index: currentIndex.value,
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
        currentIndex: currentIndex,
        iconList: iconList,
      ),
    );
  }
}

class _BottomNavigationBar extends HookWidget {
  final ValueNotifier<int> currentIndex;
  final List<Pair> iconList;

  const _BottomNavigationBar({
    required this.currentIndex,
    required this.iconList,
  });

  @override
  Widget build(BuildContext context) {
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
              height: 80,
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
                    selectedItemColor: getColorScheme(context).colorPrimary500,
                    unselectedItemColor: getColorScheme(context).colorGray300,
                    currentIndex: currentIndex.value,
                    onTap: (index) => currentIndex.value = index,
                    items: iconList.map((data) {
                      return BottomNavigationBarItem(
                        icon: Column(
                          children: [
                            SvgPicture.asset(
                              data.first,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                getColorScheme(context).colorGray300,
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
                              data.first,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                getColorScheme(context).colorPrimary500,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            )
                          ],
                        ),
                        label: data.second,
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
