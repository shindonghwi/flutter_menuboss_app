import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarTitle.dart';
import 'package:menuboss/presentation/components/divider/DividerVertical.dart';
import 'package:menuboss/presentation/components/loader/LoadProfile.dart';
import 'package:menuboss/presentation/components/placeholder/ProfilePlaceholder.dart';
import 'package:menuboss/presentation/components/popup/CommonPopup.dart';
import 'package:menuboss/presentation/components/popup/PopupLogout.dart';
import 'package:menuboss/presentation/components/progress/LinearAnimationProgressBar.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/features/login/provider/MeInfoProvider.dart';
import 'package:menuboss/presentation/features/main/my/provider/LogoutProvider.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

import '../../../components/view_state/LoadingView.dart';

class MyScreen extends HookConsumerWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logoutState = ref.watch(logoutProvider);
    final meInfo = ref.watch(meInfoProvider);
    final meInfoManager = ref.read(meInfoProvider.notifier);
    final logoutManager = ref.read(logoutProvider.notifier);

    void goToLogin() {
      meInfoManager.updateMeInfo(null);
      Navigator.pushAndRemoveUntil(
        context,
        nextFadeInOutScreen(RoutingScreen.Login.route),
        (route) => false,
      );
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        logoutState.when(
          success: (event) async {
            logoutManager.init();
            goToLogin();
          },
          failure: (event) {
            Toast.showError(context, event.errorMessage);
          },
        );
      });
      return null;
    }, [logoutState]);

    return BaseScaffold(
      backgroundColor: getColorScheme(context).white,
      appBar: TopBarTitle(
        content: getAppLocalizations(context).main_navigation_menu_my,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 24),
                _UserProfile(
                  imageUrl: meInfo?.profile?.imageUrl,
                  role: meInfo?.business?.role,
                  name: meInfo?.profile?.name,
                  businessName: meInfo?.business?.title,
                  email: meInfo?.email,
                ),
                // SizedBox(height: 24),
                // _UserPlanScreenInfo(),
                const DividerVertical(marginVertical: 12),
                const _SettingItems(),
              ],
            ),
            if (logoutState is Loading) const LoadingView()
          ],
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
      height: 100,
      margin: const EdgeInsets.only(left: 24, right: 12),
      child: Row(
        children: [
          LoadProfile(
            url: imageUrl ?? "",
            type: ProfileImagePlaceholderType.Size100x100,
          ),
          const SizedBox(
            width: 24,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
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
                          style: getTextTheme(context).b2sb.copyWith(
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
                          style: getTextTheme(context).c1sb.copyWith(
                                color: getColorScheme(context).colorGray700,
                              ),
                        ),
                      if (!CollectionUtil.isNullEmptyFromString(email))
                        Text(
                          email.toString(),
                          style: getTextTheme(context).c1sb.copyWith(
                                color: getColorScheme(context).colorGray700,
                              ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 12),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: getColorScheme(context).colorGray50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/imgs/icon_premium.svg",
                    width: 24,
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      'Premium',
                      style: getTextTheme(context).b3sb.copyWith(
                            color: getColorScheme(context).colorGray900,
                          ),
                    ),
                  ),
                ],
              ),
              Text(
                'Payment : Aug 24th, 2023',
                style: getTextTheme(context).c1sb.copyWith(
                      color: getColorScheme(context).colorGray500,
                    ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 12.0),
            child: const LinearAnimationProgressBar(
              percentage: 0.5,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Screens : 3 /4',
                style: getTextTheme(context).c1m.copyWith(
                      color: getColorScheme(context).colorGray500,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingItems extends HookConsumerWidget {
  const _SettingItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logoutManager = ref.read(logoutProvider.notifier);

    final items = [
      Pair(getAppLocalizations(context).my_page_setting_items_profile, () {
        Navigator.push(
          context,
          nextSlideHorizontalScreen(RoutingScreen.MyProfile.route),
        );
      }),
      Pair(getAppLocalizations(context).my_page_setting_items_log_out, () {
        CommonPopup.showPopup(
          context,
          child: PopupLogout(onClicked: (isCompleted) {
            if (isCompleted) {
              logoutManager.requestLogout();
            }
          }),
        );
      }),
    ];

    return Expanded(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                getAppLocalizations(context).my_page_setting_item,
                style: getTextTheme(context).b3sb.copyWith(
                      color: getColorScheme(context).colorGray900,
                    ),
                textAlign: TextAlign.start,
              ),
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 0);
              },
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];
                return Clickable(
                  onPressed: item.second,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.first,
                          style: getTextTheme(context).b3sb.copyWith(
                                color: getColorScheme(context).colorGray900,
                              ),
                        ),
                        SvgPicture.asset(
                          "assets/imgs/icon_next.svg",
                          colorFilter: ColorFilter.mode(
                            getColorScheme(context).colorGray600,
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
          ],
        ),
      ),
    );
  }
}
