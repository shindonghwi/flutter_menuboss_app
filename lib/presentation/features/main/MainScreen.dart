import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/features/main/home/HomeScreen.dart';
import 'package:menuboss/presentation/features/main/profile/ProfileScreen.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

class MainScreen extends HookWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(0);

    List<Pair> iconList = [
      Pair('assets/imgs/icon_setting.svg', "Home"),
      Pair('assets/imgs/icon_setting.svg', "MyPage"),
    ];

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          IndexedStack(
            index: currentIndex.value,
            children: const [
              HomeScreen(),
              ProfileScreen(),
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

class _BottomNavigationBar extends HookConsumerWidget {
  final ValueNotifier<int> currentIndex;
  final List<Pair> iconList;

  const _BottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.iconList,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
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
                          Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
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
                          Colors.blue,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      )
                    ],
                  ),
                  label: data.second,
                );
              }).toList(),
              selectedLabelStyle: getTextTheme(context).c1b,
              unselectedLabelStyle: getTextTheme(context).c2r,
            ),
          ),
        ),
      ],
    );
  }
}
