import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/features/login/provider/MeInfoProvider.dart';
import 'package:menuboss_common/components/appbar/TopBarTitle.dart';
import 'package:menuboss_common/components/divider/DividerVertical.dart';
import 'package:menuboss_common/components/loader/LoadProfile.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/placeholder/PlaceholderType.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/utils/ClickableScale.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/Common.dart';

class MyScreen extends HookConsumerWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meInfo = ref.watch(meInfoProvider);

    return BaseScaffold(
      backgroundColor: getColorScheme(context).white,
      appBar: TopBarTitle(
        content: getString(context).mainNavigationMenuMy,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              _UserProfile(
                imageUrl: meInfo?.profile?.imageUrl,
                role: meInfo?.business?.role,
                name: meInfo?.profile?.name,
                businessName: meInfo?.business?.title,
                email: meInfo?.email,
              ),
              DividerVertical(
                marginVertical: 0,
                dividerColor: getColorScheme(context).colorGray100,
              ),

              const SizedBox(height: 8),

              // 설정
              _MenuContent(
                title: _SettingTitle(title: getString(context).myPageSettingItemTitleSetting),
                menuList: [
                  _SettingContent(
                    content: getString(context).myPageSettingSubmenuTeam,
                    onPressed: () {},
                  ),
                  _SettingContent(
                    content: getString(context).myPageSettingSubmenuRole,
                    onPressed: () {},
                  ),
                  DividerVertical(
                    marginVertical: 8,
                    height: 1,
                    dividerColor: getColorScheme(context).colorGray100,
                  ),
                ],
              ),

              // 사용자 설정
              _MenuContent(
                title: _SettingTitle(title: getString(context).myPageSettingItemTitleUser),
                menuList: [
                  _SettingContent(
                    content: getString(context).myPageSettingSubmenuMy,
                    onPressed: () {
                      Navigator.push(
                        context,
                        nextSlideHorizontalScreen(RoutingScreen.MyAccount.route),
                      );
                    },
                  ),
                  _SettingContent(
                    content: getString(context).myPageSettingSubmenuBusiness,
                    onPressed: () {},
                  ),
                  DividerVertical(
                    marginVertical: 8,
                    height: 1,
                    dividerColor: getColorScheme(context).colorGray100,
                  ),
                ],
              ),

              // 가이드
              _MenuContent(
                title: _SettingTitle(title: getString(context).myPageSettingSubmenuGuide),
                menuList: [
                  _SettingContent(
                    content: getString(context).myPageSettingSubmenuMenual,
                    onPressed: () {
                      Navigator.push(
                        context,
                        nextSlideHorizontalScreen(RoutingScreen.GuideList.route),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserProfile extends HookWidget {
  final String? imageUrl;
  final String? role;
  final String? name;
  final String? businessName;
  final String? email;

  const _UserProfile({
    super.key,
    required this.imageUrl,
    required this.role,
    required this.name,
    required this.businessName,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          LoadProfile(
            url: imageUrl ?? "",
            type: ProfileImagePlaceholderType.Size80x80,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!CollectionUtil.isNullEmptyFromString(role))
                      Container(
                        decoration: BoxDecoration(
                          color: getColorScheme(context).colorPrimary500,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        margin: const EdgeInsets.only(bottom: 4),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Text(
                            role.toString(),
                            style: getTextTheme(context).c2m.copyWith(
                                  color: getColorScheme(context).white,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    if (!CollectionUtil.isNullEmptyFromString(name))
                      Text(
                        name.toString(),
                        style: getTextTheme(context).b2m.copyWith(
                              color: getColorScheme(context).colorGray900,
                            ),
                      ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!CollectionUtil.isNullEmptyFromString(businessName))
                      Text(
                        businessName.toString(),
                        style: getTextTheme(context).c1m.copyWith(
                              color: getColorScheme(context).colorGray700,
                            ),
                      ),
                    if (!CollectionUtil.isNullEmptyFromString(email))
                      Text(
                        email.toString(),
                        style: getTextTheme(context).c1m.copyWith(
                              color: getColorScheme(context).colorGray700,
                            ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuContent extends StatelessWidget {
  final Widget title;
  final List<Widget> menuList;

  const _MenuContent({
    super.key,
    required this.title,
    required this.menuList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        ...menuList,
      ],
    );
  }
}

class _SettingTitle extends StatelessWidget {
  final String title;

  const _SettingTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        title,
        style: getTextTheme(context).c1sb.copyWith(
              color: getColorScheme(context).colorGray700,
            ),
        textAlign: TextAlign.start,
      ),
    );
  }
}

class _SettingContent extends StatelessWidget {
  final String content;
  final VoidCallback? onPressed;

  const _SettingContent({
    super.key,
    required this.content,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ClickableScale(
        onPressed: onPressed == null ? null : () => onPressed?.call(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              content,
              style: getTextTheme(context).b3m.copyWith(
                    color: getColorScheme(context).colorGray900,
                  ),
              textAlign: TextAlign.start,
            ),
            if (onPressed != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LoadSvg(
                  path: "assets/imgs/icon_next.svg",
                  width: 20,
                  height: 20,
                  color: getColorScheme(context).colorGray600,
                ),
              )
          ],
        ),
      ),
    );
  }
}
