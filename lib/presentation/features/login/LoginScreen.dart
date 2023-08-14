import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/Clickable/Clickable.dart';
import 'package:menuboss/presentation/components/button/FillButton.dart';
import 'package:menuboss/presentation/components/textfield/OutlineTextField.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
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
    return const FillButton.round(content: Text("Log in"), isActivated: true);
  }
}

class _Title extends StatelessWidget {
  const _Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Login"),
          Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Text("Welcome! Please enter your details"),
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
          const Text("Email Address"),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: OutlineTextField(
              controller: useTextEditingController(),
              hint: 'Email',
              successMessage: "heelo success",
              errorMessage: "heelo error",
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
          const Text("Password"),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: OutlineTextField(
              controller: useTextEditingController(),
              hint: 'Password',
              successMessage: "heelo success",
              errorMessage: "heelo error",
            ),
          ),
        ],
      ),
    );
  }
}
