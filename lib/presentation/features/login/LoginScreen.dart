import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/components/textfield/OutlineTextField.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/features/login/provider/LoginProvider.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/RegUtil.dart';

import '../../components/view_state/LoadingView.dart';
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
                margin: const EdgeInsets.fromLTRB(24, 80, 24, 0),
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
                      const SizedBox(height: 20),
                      _LoginButton(isActivated: isEmailValid.value && isPwValid.value),
                      const SizedBox(height: 16),
                      const _SignUpButton()
                      // const _SocialLoginButtons(),
                      // const SizedBox(height: 40),
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
          getAppLocalizations(context).login_no_account,
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
              getAppLocalizations(context).common_sign_up,
              style: getTextTheme(context).b3m.copyWith(
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
              Flexible(child: Container(height: 1, color: getColorScheme(context).colorGray300)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  getAppLocalizations(context).common_or,
                  style: getTextTheme(context).b3m.copyWith(
                        color: getColorScheme(context).colorGray500,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Flexible(child: Container(height: 1, color: getColorScheme(context).colorGray300)),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Clickable(
              borderRadius: 8,
              onPressed: () => loginManager.doGoogleLogin(),
              child: SvgPicture.asset("assets/imgs/icon_google.svg", width: 64, height: 64),
            ),
            const SizedBox(width: 32),
            Clickable(
              borderRadius: 8,
              onPressed: () => loginManager.doAppleLogin(),
              child: SvgPicture.asset("assets/imgs/icon_apple.svg", width: 64, height: 64),
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
        content: getAppLocalizations(context).common_do_login,
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
            getAppLocalizations(context).login_title,
            style: getTextTheme(context).h3sb.copyWith(
                  color: getColorScheme(context).colorGray900,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              getAppLocalizations(context).login_welcome,
              style: getTextTheme(context).b1r.copyWith(
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
            "${getAppLocalizations(context).common_email} ${getAppLocalizations(context).common_address}",
            style: getTextTheme(context).b3m.copyWith(
                  color: getColorScheme(context).colorGray800,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: OutlineTextField.small(
              controller: useTextEditingController(),
              hint: getAppLocalizations(context).common_email,
              successMessage: getAppLocalizations(context).login_email_correct,
              errorMessage: getAppLocalizations(context).login_email_invalid,
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
            getAppLocalizations(context).common_password,
            style: getTextTheme(context).b3m.copyWith(
                  color: getColorScheme(context).colorGray800,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: OutlineTextField.small(
              controller: useTextEditingController(),
              hint: getAppLocalizations(context).common_password,
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
