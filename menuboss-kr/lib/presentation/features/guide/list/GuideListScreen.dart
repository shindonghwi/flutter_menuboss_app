import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/app/env/Environment.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/features/guide/detail/GuideDetailScreen.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/components/utils/ClickableScale.dart';
import 'package:menuboss_common/ui/Strings.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class _GuideItem {
  final String title;
  final String description;
  final VoidCallback onPressed;

  _GuideItem({
    required this.title,
    required this.description,
    required this.onPressed,
  });
}

class GuideListScreen extends StatelessWidget {
  const GuideListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<_GuideItem> guideList = [
      _GuideItem(
        title: Strings.of(context).guideListItemDeviceTitle,
        description: Strings.of(context).guideListItemDeviceDescription,
        onPressed: () {
          Navigator.push(
            context,
            nextSlideHorizontalScreen(
              RoutingScreen.GuideDetail.route,
              parameter: GuideType.device,
            ),
          );
        },
      ),
      _GuideItem(
        title: Strings.of(context).guideListItemScheduleTitle,
        description: Strings.of(context).guideListItemScheduleDescription,
        onPressed: () {
          Navigator.push(
            context,
            nextSlideHorizontalScreen(
              RoutingScreen.GuideDetail.route,
              parameter: GuideType.schedule,
            ),
          );
        },
      ),
      _GuideItem(
        title: Strings.of(context).guideListItemPlaylistTitle,
        description: Strings.of(context).guideListItemScheduleDescription,
        onPressed: () {
          Navigator.push(
            context,
            nextSlideHorizontalScreen(
              RoutingScreen.GuideDetail.route,
              parameter: GuideType.playlist,
            ),
          );
        },
      ),
      _GuideItem(
        title: Strings.of(context).guideListItemMediaTitle,
        description: Strings.of(context).guideListItemMediaDescription,
        onPressed: () {
          Navigator.push(
            context,
            nextSlideHorizontalScreen(
              RoutingScreen.GuideDetail.route,
              parameter: GuideType.media,
            ),
          );
        },
      ),
    ];

    return BaseScaffold(
      appBar: TopBarIconTitleNone(
        content: Strings.of(context).guideListTitle,
        onBack: () => popPageWrapper(context: context),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 12);
          },
          itemBuilder: (BuildContext context, int index) {
            return _Content(item: guideList[index]);
          },
          itemCount: guideList.length,
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Clickable(
                onPressed: () {
                  launchUrlString(
                    "${Environment.webUrl}/guides/Quick_Start_Guide_App_KR_ver1.0.pdf",
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: getColorScheme(context).colorGray400,
                          width: 1.0,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.only(bottom: 4.0), // 이 부분을 조절하여 간격 변경
                    child: Text(
                      Strings.of(context).guideListDetailView,
                      style: getTextTheme(context).b3m.copyWith(
                            color: getColorScheme(context).colorGray400,
                          ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Content extends HookWidget {
  final _GuideItem item;

  const _Content({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return ClickableScale(
      onPressed: () => item.onPressed.call(),
      child: Container(
        height: 84,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: getColorScheme(context).colorGray50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.title,
                  style: getTextTheme(context).b2m.copyWith(
                        color: getColorScheme(context).colorGray900,
                      ),
                ),
                Text(
                  item.description,
                  style: getTextTheme(context).b3m.copyWith(
                        color: getColorScheme(context).colorGray500,
                      ),
                ),
              ],
            ),
            LoadSvg(
              path: "assets/imgs/icon_next.svg",
              width: 20,
              height: 20,
              color: getColorScheme(context).colorGray600,
            ),
          ],
        ),
      ),
    );
  }
}
