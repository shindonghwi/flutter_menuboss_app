import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/Clickable/Clickable.dart';
import 'package:menuboss/presentation/components/button/FillButton.dart';
import 'package:menuboss/presentation/components/textfield/OutlineTextField.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/RegUtil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorScheme(context).white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(24, 80, 24, 0),
          child: const Column(
            children: [
              _Title(),
              SizedBox(height: 40),
              _InputEmail(),
              SizedBox(height: 16),
              _InputPassword(),
              SizedBox(height: 20),
              _LoginButton(),
              SizedBox(height: 24),
              _SocialLoginButtons(),
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
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Flexible(child: Container(height: 1, color: Colors.grey)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text("or"),
              ),
              Flexible(child: Container(height: 1, color: Colors.grey)),
            ],
          ),
        ),
        SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Clickable(
              borderRadius: 8,
              onPressed: () {},
              child: SvgPicture.asset("assets/imgs/icon_google.svg"),
            ),
            SizedBox(width: 32),
            Clickable(
              borderRadius: 8,
              onPressed: () {},
              child: SvgPicture.asset("assets/imgs/icon_apple.svg"),
            )
          ],
        ),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FillButton.round(
      content: Text("Log in"),
      isActivated: true,
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutingScreen.Main.route,
          (route) => false,
        );
      },
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
  const _InputEmail({
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
            ),
          ),
        ],
      ),
    );
  }
}

class _InputPassword extends HookWidget {
  const _InputPassword({
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
            ),
          ),
        ],
      ),
    );
  }
}
