import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/features/login/provider/MeInfoProvider.dart';
import 'package:menuboss/presentation/features/main/my/provider/LogoutProvider.dart';
import 'package:menuboss_common/components/appbar/TopBarTitle.dart';
import 'package:menuboss_common/components/loader/LoadProfile.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/placeholder/PlaceholderType.dart';
import 'package:menuboss_common/components/popup/CommonPopup.dart';
import 'package:menuboss_common/components/popup/PopupLogout.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/Strings.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/UiState.dart';
import 'package:menuboss_common/utils/dto/Pair.dart';

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
        content: Strings.of(context).mainNavigationMenuMy,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _UserProfile(
                  imageUrl: meInfo?.profile?.imageUrl,
                  role: meInfo?.business?.role,
                  name: meInfo?.profile?.name,
                  businessName: meInfo?.business?.title,
                  email: meInfo?.email,
                ),
                Container(
                  width: double.infinity,
                  height: 8,
                  color: getColorScheme(context).colorGray100,
                ),
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

class _SettingItems extends HookConsumerWidget {
  const _SettingItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logoutManager = ref.read(logoutProvider.notifier);

    final items = [
      Pair(Strings.of(context).myPageSettingItemsProfile, () {
        Navigator.push(
          context,
          nextSlideHorizontalScreen(RoutingScreen.MyProfile.route),
        );
      }),
      Pair(Strings.of(context).commonLogout, () {
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
                Strings.of(context).myPageSettingItem,
                style: getTextTheme(context).b3sb.copyWith(
                      color: getColorScheme(context).colorGray700,
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
                          style: getTextTheme(context).b3m.copyWith(
                                color: getColorScheme(context).colorGray900,
                              ),
                        ),
                        LoadSvg(
                          path: "assets/imgs/icon_next.svg",
                          color: getColorScheme(context).colorGray600,
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
