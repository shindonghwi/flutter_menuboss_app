import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/data_source/remote/HeaderKey.dart';
import 'package:menuboss/data/data_source/remote/Service.dart';
import 'package:menuboss/domain/usecases/local/app/GetLoginAccessTokenUseCase.dart';
import 'package:menuboss/domain/usecases/remote/me/GetMeInfoUseCase.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/features/login/provider/MeInfoProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:uni_links/uni_links.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meInfoManager = ref.read(meInfoProvider.notifier);
    final initialLinkFuture = useMemoized(() => getInitialLink(), []);
    final initialLink = useFuture(initialLinkFuture);

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

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
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
      });

      StreamSubscription subscription;
      subscription = uriLinkStream.listen((Uri? link) {
        handleDeepLink(link?.toString());
      }, onError: (err) {});

      // Cleanup: 스트림 구독을 취소하여 리소스를 해제합니다.
      return () => subscription.cancel();
    }, []);

    return BaseScaffold(
      backgroundColor: getColorScheme(context).colorPrimary500,
      body: Center(
        child: SvgPicture.asset(
          "assets/imgs/splash_logo.svg",
          width: 128,
          height: 64,
        ),
      ),
    );
  }
}
