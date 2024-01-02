import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/me/RequestMeSocialJoinModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/features/login/provider/LoginProvider.dart';
import 'package:menuboss_common/components/button/PrimaryFilledButton.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/textfield/OutlineTextField.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/strings.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/RegUtil.dart';
import 'package:menuboss_common/utils/UiState.dart';

import 'provider/MeInfoProvider.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final loginManager = ref.read(loginProvider.notifier);
    final meInfoManager = ref.read(meInfoProvider.notifier);
    final isEmailValid = useState(false);
    final isPwValid = useState(false);

    void goToMainScreen() {
      Navigator.pushReplacement(
        context,
        nextFadeInOutScreen(RoutingScreen.Main.route),
      );
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        loginState.when(
          success: (event) async {
            loginManager.init();
            if (loginManager.meInfo != null) {
              meInfoManager.updateMeInfo(loginManager.meInfo);
            }
            goToMainScreen();
          },
          failure: (event) {
            Toast.showError(context, event.errorMessage);
          },
        );
      });
      return null;
    }, [loginState]);

    return BaseScaffold(
        backgroundColor: getColorScheme(context).white,
        body: Stack(
          children: [
            SafeArea(
              child: Container(
                margin: const EdgeInsets.fromLTRB(24, 96, 24, 0),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const _Title(),
                      const SizedBox(height: 40),
                      _InputEmail(
                        onChanged: (text) {
                          loginManager.updateEmail(text);
                          isEmailValid.value = RegUtil.checkEmail(text);
                        },
                      ),
                      const SizedBox(height: 16),
                      _InputPassword(
                        onChanged: (text) {
                          loginManager.updatePassword(text);
                          isPwValid.value = text.isNotEmpty;
                        },
                      ),
                      const SizedBox(height: 32),
                      _LoginButton(isActivated: isEmailValid.value && isPwValid.value),
                      const SizedBox(height: 24),
                      const _SignUpButton(),
                      const SizedBox(height: 28),
                      const _SocialLoginButtons(),
                    ],
                  ),
                ),
              ),
            ),
            if (loginState is Loading) const LoadingView(),
          ],
        ));
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Strings.of(context).loginNoAccount,
          style: getTextTheme(context).b3m.copyWith(
                color: getColorScheme(context).colorGray500,
              ),
        ),
        const SizedBox(width: 4),
        Clickable(
          onPressed: () {
            Navigator.push(
              context,
              nextSlideHorizontalScreen(
                RoutingScreen.SignUp.route,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              Strings.of(context).commonSignUp,
              style: getTextTheme(context).b3sb.copyWith(
                    color: getColorScheme(context).colorPrimary500,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SocialLoginButtons extends HookConsumerWidget {
  const _SocialLoginButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginManager = ref.read(loginProvider.notifier);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  height: 1,
                  color: getColorScheme(context).colorGray300,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  Strings.of(context).commonOr,
                  style: getTextTheme(context).b3m.copyWith(
                        color: getColorScheme(context).colorGray500,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Flexible(
                child: Container(
                  height: 1,
                  color: getColorScheme(context).colorGray300,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Clickable(
              borderRadius: 8,
              onPressed: () async {
                RequestMeSocialJoinModel? socialJoinModel = await loginManager.doGoogleLogin();
                if (socialJoinModel != null) {
                  Navigator.push(
                    context,
                    nextSlideHorizontalScreen(RoutingScreen.SignUp.route,
                        parameter: socialJoinModel),
                  );
                }
              },
              child: const LoadSvg(
                path: "assets/imgs/icon_google.svg",
                width: 64,
                height: 64,
              ),
            ),
            const SizedBox(width: 32),
            Clickable(
              borderRadius: 8,
              onPressed: () async {
                RequestMeSocialJoinModel? socialJoinModel = await loginManager.doAppleLogin();
                if (socialJoinModel != null) {
                  Navigator.push(
                    context,
                    nextSlideHorizontalScreen(RoutingScreen.SignUp.route,
                        parameter: socialJoinModel),
                  );
                }
              },
              child: const LoadSvg(
                path: "assets/imgs/icon_apple.svg",
                width: 64,
                height: 64,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class _LoginButton extends HookConsumerWidget {
  final bool isActivated;

  const _LoginButton({
    super.key,
    required this.isActivated,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginManager = ref.read(loginProvider.notifier);

    return SizedBox(
      width: double.infinity,
      child: PrimaryFilledButton.mediumRound8(
        content: Strings.of(context).commonDoLogin,
        isActivated: isActivated,
        onPressed: () {
          // FirebaseCrashlytics.instance.crash();
          loginManager.doEmailLogin();
        },
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.of(context).loginTitle,
            style: getTextTheme(context).s1sb.copyWith(
                  color: getColorScheme(context).colorGray900,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              Strings.of(context).loginWelcome,
              style: getTextTheme(context).b2m.copyWith(
                    color: getColorScheme(context).colorGray700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InputEmail extends HookWidget {
  final Function(String) onChanged;

  const _InputEmail({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.of(context).commonEmail,
            style: getTextTheme(context).b3m.copyWith(
                  color: getColorScheme(context).colorGray800,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: OutlineTextField.medium(
              controller: useTextEditingController(),
              hint: Strings.of(context).commonEmail,
              successMessage: Strings.of(context).loginEmailCorrect,
              errorMessage: Strings.of(context).loginEmailInvalid,
              checkRegList: const [
                RegCheckType.Email,
              ],
              onChanged: (text) => onChanged(text),
            ),
          ),
        ],
      ),
    );
  }
}

class _InputPassword extends HookWidget {
  final Function(String) onChanged;

  const _InputPassword({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.of(context).commonPassword,
            style: getTextTheme(context).b3m.copyWith(
                  color: getColorScheme(context).colorGray800,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: OutlineTextField.medium(
              controller: useTextEditingController(),
              hint: Strings.of(context).commonPassword,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.visiblePassword,
              showPwVisibleButton: true,
              showSuffixStatusIcon: false,
              onChanged: (text) => onChanged(text),
            ),
          ),
        ],
      ),
    );
  }
}
