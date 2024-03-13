import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss_common/components/popup/CommonPopup.dart';
import 'package:menuboss_common/components/popup/PopupLogout.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/UiState.dart';
import 'package:menuboss_common/utils/dto/Pair.dart';

import '../../../login/provider/MeInfoProvider.dart';
import '../provider/LogoutProvider.dart';

class MyAccountScreen extends HookConsumerWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logoutState = ref.watch(logoutProvider);
    final logoutManager = ref.read(logoutProvider.notifier);
    final meInfoManager = ref.read(meInfoProvider.notifier);

    final menuItems = [
      Pair(getString(context).myPageAccountMenuProfile, () {
        Navigator.push(
          context,
          nextSlideHorizontalScreen(RoutingScreen.MyProfile.route),
        );
      }),
      Pair(getString(context).myPageAccountMenuPassword, () {
        Navigator.push(
          context,
          nextSlideHorizontalScreen(RoutingScreen.MyPassword.route),
        );
      }),
      Pair(getString(context).myPageAccountMenuLogout, () {
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
      appBar: TopBarIconTitleNone(
        content: getString(context).myPageAccountAppbarTitle,
        onBack: () => popPageWrapper(context: context),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: menuItems.map((e) {
                return Clickable(
                  onPressed: () => e.second.call(),
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        e.first,
                        style: getTextTheme(context).b3m.copyWith(
                              color: getColorScheme(context).colorGray900,
                            ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            if (logoutState is Loading) const LoadingView()
          ],
        ),
      ),
    );
  }
}
