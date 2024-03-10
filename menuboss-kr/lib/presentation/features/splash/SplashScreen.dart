import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/data_source/remote/HeaderKey.dart';
import 'package:menuboss/data/data_source/remote/Service.dart';
import 'package:menuboss/domain/usecases/local/app/GetLoginAccessTokenUseCase.dart';
import 'package:menuboss/domain/usecases/remote/app/GetCheckUpAppUseCase.dart';
import 'package:menuboss/domain/usecases/remote/me/GetMeInfoUseCase.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/features/login/provider/MeInfoProvider.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/popup/CommonPopup.dart';
import 'package:menuboss_common/components/popup/PopupForceUpdate.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/utils/LifecycleWatcher.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/StringUtil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:restart_app/restart_app.dart';
import 'package:uni_links/uni_links.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isUserActionGoToStore = false; // 사용자가 업데이트 버튼을 눌렀는지
    final meInfoManager = ref.read(meInfoProvider.notifier);
    final initialLinkFuture = useMemoized(() => getInitialLink(), []);
    final initialLink = useFuture(initialLinkFuture);

    Future<bool> isForceUpdateCheck() async {
      final response = await GetIt.instance<GetCheckUpAppUseCase>().call();
      if (response.status == 200) {
        final latestVersionStr = response.data?.latestVersion;
        final currentVersionStr = (await PackageInfo.fromPlatform()).version;

        final latestVersion = StringUtil.extractNumbers(latestVersionStr!);
        final currentVersion = StringUtil.extractNumbers(currentVersionStr);

        if (currentVersion.compareTo(latestVersion) < 0) {
          return Future(() => true);
        }
      }
      return Future(() => false);
    }

    /**
     * @feature: 자동로그인
     *
     * @author: 2023/09/12 6:40 PM donghwishin
     *
     * @description{
     *   저장된 사용자 토큰이 있을 경우, 불러와서 Me API 호출을 진행한다.
     *   저장된 사용자 토큰이 없을 경우, Login 화면으로 이동한다.
     *   Me API 호출이 성공할 경우, Main 화면으로 이동한다.
     *   Me API 호출이 실패할 경우, Login 화면으로 이동한다.
     * }
     */
    Future<RoutingScreen?> runAutoLogin() async {
      final accessToken = await GetIt.instance<GetLoginAccessTokenUseCase>().call();

      if (!CollectionUtil.isNullEmptyFromString(accessToken)) {
        final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
        Service.addHeader(key: HeaderKey.ApplicationTimeZone, value: timeZone);
        Service.addHeader(key: HeaderKey.Authorization, value: accessToken);
        final result = await GetIt.instance<GetMeInfoUseCase>().call();

        if (result.status == 200 && result.data != null) {
          meInfoManager.updateMeInfo(result.data);
          return RoutingScreen.Main;
        }
      }

      return RoutingScreen.Login;
    }

    // cold start deeplink 처리
    Future<bool> coldStartDeepLink() async {
      final initialUri = await getInitialUri();
      if (initialUri != null) {
        handleDeepLink(initialUri.toString());
        return Future(() => true);
      } else {
        return Future(() => false);
      }
    }

    void screenMoveProcess() async {
      final screenToMove = await runAutoLogin();

      // cold start deeplink 처리
      if (await coldStartDeepLink()) {
        return;
      }
      // warm start deeplink 처리
      else if (initialLink.hasData) {
        handleDeepLink(initialLink.data);
        return;
      }

      // 딥링크 데이터가 없고, runAutoLogin의 결과가 있을 때만 화면 이동
      else if (screenToMove != null) {
        movePage(screenToMove);
        return;
      }
      movePage(RoutingScreen.Login);
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final isForceUpdate = await isForceUpdateCheck();
        if (isForceUpdate) {
          CommonPopup.showPopup(
            context,
            barrierDismissible: false,
            child: PopupForceUpdate(
              onClick: () => isUserActionGoToStore = true,
            ),
          );
        } else {
          screenMoveProcess();
        }
      });

      StreamSubscription subscription;
      subscription = uriLinkStream.listen((Uri? link) {
        handleDeepLink(link?.toString());
      }, onError: (err) {});

      // Cleanup: 스트림 구독을 취소하여 리소스를 해제합니다.
      return () => subscription.cancel();
    }, []);

    return LifecycleWatcher(
      onLifeCycleChanged: (state) async {
        if (state == AppLifecycleState.resumed) {
          final isForceUpdate = await isForceUpdateCheck();
          if (!isForceUpdate) {
            screenMoveProcess();
          } else {
            if (isUserActionGoToStore) {
              Restart.restartApp();
            }
          }
        }
      },
      child: BaseScaffold(
        backgroundColor: getColorScheme(context).colorPrimary500,
        body: const Center(
          child: LoadSvg(
            path: "assets/imgs/splash_logo.svg",
            width: 128,
            height: 64,
          ),
        ),
      ),
    );
  }
}
