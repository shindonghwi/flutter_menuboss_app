import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/Clickable/Clickable.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/components/textfield/OutlineTextField.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/RegUtil.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isEmailValid = useState(false);
    final isPwValid = useState(false);

    return Scaffold(
      backgroundColor: getColorScheme(context).white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(24, 80, 24, 0),
          child: Column(
            children: [
              const _Title(),
              const SizedBox(height: 40),
              _InputEmail(
                onChanged: (text) => isEmailValid.value = RegUtil.checkEmail(text),
              ),
              const SizedBox(height: 16),
              _InputPassword(
                onChanged: (text) => isPwValid.value = RegUtil.checkPw(text),
              ),
              const SizedBox(height: 20),
              _LoginButton(isActivated: isEmailValid.value && isPwValid.value),
              const SizedBox(height: 24),
              const _SocialLoginButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialLoginButtons extends StatelessWidget {
  const _SocialLoginButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Flexible(child: Container(height: 1, color: getColorScheme(context).colorGray500)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  getAppLocalizations(context).common_or,
                  style: getTextTheme(context).b2m.copyWith(
                        color: getColorScheme(context).colorGray500,
                      ),
                ),
              ),
              Flexible(child: Container(height: 1, color: getColorScheme(context).colorGray500)),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Clickable(
              borderRadius: 8,
              onPressed: () {},
              child: SvgPicture.asset("assets/imgs/icon_google.svg", width: 64, height: 64),
            ),
            const SizedBox(width: 32),
            Clickable(
              borderRadius: 8,
              onPressed: () {},
              child: SvgPicture.asset("assets/imgs/icon_apple.svg", width: 64, height: 64),
            )
          ],
        ),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  final bool isActivated;

  const _LoginButton({
    super.key,
    required this.isActivated,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: PrimaryFilledButton.normalRect(
        content: getAppLocalizations(context).common_do_login,
        isActivated: isActivated,
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutingScreen.Main.route,
            (route) => false,
          );
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
            style: getTextTheme(context).h1b.copyWith(
                  color: getColorScheme(context).colorGray900,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              getAppLocalizations(context).login_welcome,
              style: getTextTheme(context).b1sb.copyWith(
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
            style: getTextTheme(context).b2sb.copyWith(
                  color: getColorScheme(context).colorGray900,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: OutlineTextField(
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
            style: getTextTheme(context).b2sb.copyWith(
                  color: getColorScheme(context).colorGray900,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: OutlineTextField(
              controller: useTextEditingController(),
              hint: getAppLocalizations(context).common_password,
              errorMessage: getAppLocalizations(context).login_pw_invalid,
              checkRegList: const [
                RegCheckType.PW,
              ],
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.visiblePassword,
              showPwVisibleButton: true,
              onChanged: (text) => onChanged(text),
            ),
          ),
        ],
      ),
    );
  }
}
