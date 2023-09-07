import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarTitle.dart';
import 'package:menuboss/presentation/components/progress/LinearAnimationProgressBar.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: getColorScheme(context).white,
      appBar: TopBarTitle(
        content: getAppLocalizations(context).my_page_appbar_title,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            const _UserProfile(),
            const SizedBox(height: 24),
            const _UserPlanScreenInfo(),
            Container(
              width: double.infinity,
              height: 1,
              margin: const EdgeInsets.symmetric(vertical: 32),
              color: getColorScheme(context).colorGray200,
            ),
            const _SettingItems(),
          ],
        ),
      ),
    );
  }
}

class _UserProfile extends HookWidget {
  const _UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 12),
      child: Row(
        children: [
          // Container(
          //   width: 80,
          //   height: 80,
          //   decoration: BoxDecoration(
          //     color: getColorScheme(context).colorGray100,
          //     borderRadius: BorderRadius.circular(100),
          //   ),
          //   child: FittedBox(
          //     fit: BoxFit.scaleDown,
          //     child: Image.asset(
          //       "assets/imgs/image_default.png",
          //       width: 40,
          //       height: 20,
          //     ),
          //   ),
          // ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MenuBoss',
                style: getTextTheme(context).b1b.copyWith(
                      color: getColorScheme(context).colorGray900,
                    ),
              ),
              Text(
                'admin@menuboss.com',
                style: getTextTheme(context).b2m.copyWith(
                      color: getColorScheme(context).colorGray500,
                    ),
              ),
            ],
          ),
          // Expanded(
          //   child: Align(
          //     alignment: Alignment.centerRight,
          //     child: Clickable(
          //       onPressed: () {},
          //       child: Padding(
          //         padding: const EdgeInsets.all(12.0),
          //         child: SvgPicture.asset(
          //           "assets/imgs/icon_log_out.svg",
          //           colorFilter: ColorFilter.mode(
          //             getColorScheme(context).black,
          //             BlendMode.srcIn,
          //           ),
          //           width: 24,
          //           height: 24,
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}

class _UserPlanScreenInfo extends HookWidget {
  const _UserPlanScreenInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: getColorScheme(context).colorGray50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // SvgPicture.asset(
          //   "assets/imgs/icon_primium.svg",
          //   width: 40,
          //   height: 40,
          // ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MenuBoss',
                  style: getTextTheme(context).b1sb.copyWith(
                        color: getColorScheme(context).colorGray900,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(
                    '4 page / 12 page [Screen page]',
                    style: getTextTheme(context).c1m.copyWith(
                          color: getColorScheme(context).colorGray500,
                        ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 16.0),
                  child: const LinearAnimationProgressBar(
                    percentage: 0.5,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _SettingItems extends HookWidget {
  const _SettingItems({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      Pair(getAppLocalizations(context).my_page_setting_items_profile, () {
        Navigator.push(
          context,
          nextSlideScreen(RoutingScreen.MyProfile.route),
        );
      }),
      // Pair(getAppLocalizations(context).my_page_setting_items_plan, () {
      //   Navigator.push(
      //     context,
      //     nextSlideScreen(RoutingScreen.MyProfilePlan.route),
      //   );
      // })
    ];

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getAppLocalizations(context).my_page_setting_item,
            style: getTextTheme(context).c1sb.copyWith(
                  color: getColorScheme(context).colorGray500,
                ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 16),

          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 12);
            },
            itemBuilder: (BuildContext context, int index) {
              final item = items[index];
              return Clickable(
                onPressed: item.second,
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.first,
                        style: getTextTheme(context).b2sb.copyWith(
                              color: getColorScheme(context).colorGray900,
                            ),
                      ),
                      SvgPicture.asset(
                        "assets/imgs/icon_next.svg",
                        colorFilter: ColorFilter.mode(
                          getColorScheme(context).colorGray500,
                          BlendMode.srcIn,
                        ),
                        width: 24,
                        height: 24,
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: items.length,
          )

          //
          // Row(
          //   children: items.map((e) {
          //     return
          //   }).toList(),
          // )
        ],
      ),
    );
  }
}
