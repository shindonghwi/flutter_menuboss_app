import 'package:flutter/material.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/Clickable/Clickable.dart';
import 'package:menuboss/presentation/components/appbar/TopBarTitleButton.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/dto/Triple.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarTitleButton(
        content: getAppLocalizations(context).home_appbar_title,
        buttonContent: getAppLocalizations(context).home_appbar_add_tv,
        iconPath: 'assets/imgs/icon_plus.svg',
        onPressed: () {},
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: const Column(
            children: [
              _TvList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TvList extends StatelessWidget {
  const _TvList({super.key});

  @override
  Widget build(BuildContext context) {
    final isEmpty = false;
    return isEmpty ? const _TvContentEmpty() : const _TvContent();
  }
}

class _TvContentEmpty extends StatelessWidget {
  const _TvContentEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/imgs/image_register_scan.png",
              width: 120,
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Text(
                getAppLocalizations(context).home_tv_not_register,
                style: getTextTheme(context).b1m.copyWith(
                      color: getColorScheme(context).colorGray400,
                    ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TvContent extends StatelessWidget {
  const _TvContent({super.key});

  @override
  Widget build(BuildContext context) {
    List<Triple> items = [
      Triple("hello1", "world1", "sccren1"),
      Triple("hello2", "world2", "sccren2"),
      Triple("hello3", "world3", "sccren3"),
      Triple("hello4", "world4", "sccren4"),
      Triple("hello5", "world5", "sccren5"),
      Triple("hello6", "world36", "sccren6"),
    ];

    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 24, bottom: 60),
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 32); // Adjust the height as needed
        },
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return Clickable(
            onPressed: () {
              Navigator.push(
                context,
                nextSlideScreen(RoutingScreen.DetailTv.route),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Ink(
                      width: 340,
                      height: 200,
                      decoration: BoxDecoration(
                        color: getColorScheme(context).colorGray100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Image.asset(
                          "assets/imgs/image_default.png",
                          width: 96,
                          height: 48,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 12,
                      top: 12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: getColorScheme(context).colorGreen500,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: getColorScheme(context).colorGray600,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              getAppLocalizations(context).home_tv_screen_on,
                              style: getTextTheme(context).c1m.copyWith(
                                    color: getColorScheme(context).white,
                                  ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(item.first),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(item.second),
                ),
              ],
            ),
          );
        },
        itemCount: items.length,
      ),
    );
  }
}
