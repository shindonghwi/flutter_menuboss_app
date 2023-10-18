import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/data_source/remote/HeaderKey.dart';
import 'package:menuboss/data/data_source/remote/Service.dart';
import 'package:menuboss/data/models/me/RequestMeJoinModel.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/components/textfield/OutlineTextField.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/view_state/LoadingView.dart';
import 'package:menuboss/presentation/features/login/provider/LoginProvider.dart';
import 'package:menuboss/presentation/features/signup/provider/SignUpProvider.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/RegUtil.dart';

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useState("");
    final password = useState("");
    final fullName = useState("");
    final businessName = useState("");

    final signUpState = ref.watch(signUpProvider);
    final signUpManager = ref.read(signUpProvider.notifier);
    final loginManager = ref.read(loginProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        signUpState.when(
          success: (event) async {
            loginManager.doEmailLogin(email: email.value, password: password.value);
            signUpManager.init();
            Navigator.pop(context);
          },
          failure: (event) {
            Toast.showError(context, event.errorMessage);
          },
        );
      });
      return null;
    }, [signUpState]);

    return BaseScaffold(
      appBar: TopBarIconTitleNone(
        content: getAppLocalizations(context).common_sign_up,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 60),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Email
                  Text(
                    getAppLocalizations(context).signup_email_address,
                    style: getTextTheme(context).b3sb.copyWith(
                          color: getColorScheme(context).colorGray800,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 16),
                    child: OutlineTextField.medium(
                      controller: useTextEditingController(),
                      hint: getAppLocalizations(context).common_email,
                      successMessage: getAppLocalizations(context).login_email_correct,
                      errorMessage: getAppLocalizations(context).login_email_invalid,
                      checkRegList: const [
                        RegCheckType.Email,
                      ],
                      onChanged: (text) => email.value = text,
                    ),
                  ),

                  // Password
                  Text(
                    getAppLocalizations(context).signup_password,
                    style: getTextTheme(context).b3sb.copyWith(
                          color: getColorScheme(context).colorGray800,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 16),
                    child: OutlineTextField.medium(
                      controller: useTextEditingController(),
                      hint: getAppLocalizations(context).common_password,
                      errorMessage: getAppLocalizations(context).login_pw_invalid,
                      checkRegList: const [
                        RegCheckType.PW,
                      ],
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.visiblePassword,
                      showPwVisibleButton: true,
                      showSuffixStatusIcon: false,
                      onChanged: (text) => password.value = text,
                    ),
                  ),

                  // Full name
                  Text(
                    getAppLocalizations(context).signup_full_name,
                    style: getTextTheme(context).b3sb.copyWith(
                          color: getColorScheme(context).colorGray800,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 16),
                    child: OutlineTextField.medium(
                      controller: useTextEditingController(),
                      hint: getAppLocalizations(context).signup_full_name,
                      onChanged: (text) => fullName.value = text,
                    ),
                  ),

                  // Business name
                  Text(
                    getAppLocalizations(context).signup_business_name,
                    style: getTextTheme(context).b3sb.copyWith(
                          color: getColorScheme(context).colorGray800,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 24),
                    child: OutlineTextField.medium(
                      controller: useTextEditingController(),
                      hint: getAppLocalizations(context).signup_business_name,
                      onChanged: (text) => businessName.value = text,
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: PrimaryFilledButton.mediumRound8(
                      content: getAppLocalizations(context).common_sign_up,
                      isActivated: RegUtil.checkEmail(email.value) &&
                          email.value.isNotEmpty &&
                          RegUtil.checkPw(password.value) &&
                          password.value.isNotEmpty &&
                          fullName.value.isNotEmpty &&
                          businessName.value.isNotEmpty,
                      onPressed: () async {
                        final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
                        Service.addHeader(key: HeaderKey.ApplicationTimeZone, value: timeZone);
                        signUpManager.requestMeJoin(
                          RequestMeJoinModel(
                            email: email.value,
                            name: fullName.value,
                            password: password.value,
                            business: businessName.value,
                            timeZone: timeZone,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            if (signUpState is Loading) const LoadingView(),
          ],
        ),
      ),
    );
  }
}
