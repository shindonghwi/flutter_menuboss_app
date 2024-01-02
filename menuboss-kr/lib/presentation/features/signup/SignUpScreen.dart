import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/data_source/remote/HeaderKey.dart';
import 'package:menuboss/data/data_source/remote/Service.dart';
import 'package:menuboss/data/models/me/RequestMeJoinModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/features/login/provider/MeInfoProvider.dart';
import 'package:menuboss/presentation/features/signup/provider/SignUpProvider.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss_common/components/button/PrimaryFilledButton.dart';
import 'package:menuboss_common/components/textfield/OutlineTextField.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/strings.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/RegUtil.dart';
import 'package:menuboss_common/utils/UiState.dart';

import '../../../data/models/me/RequestMeSocialJoinModel.dart';
import 'provider/GetMeProvider.dart';

class SignUpScreen extends HookConsumerWidget {
  final RequestMeSocialJoinModel? socialJoinModel;

  const SignUpScreen({super.key, this.socialJoinModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // only email login
    final email = useState("");
    final password = useState("");

    // common (email, social)
    final fullName = useState("");
    final businessName = useState("");

    final signUpState = ref.watch(signUpProvider);
    final signUpManager = ref.read(signUpProvider.notifier);

    final getMeState = ref.watch(getMeProvider);
    final getMeManager = ref.read(getMeProvider.notifier);

    final meInfoManager = ref.read(meInfoProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        signUpState.when(
          success: (event) async {
            signUpManager.init();
            getMeManager.requestMeInfo();
          },
          failure: (event) {
            Toast.showError(context, event.errorMessage);
          },
        );
        getMeState.when(
          success: (event) async {
            getMeManager.init();
            meInfoManager.updateMeInfo(getMeManager.meInfo);
            Navigator.pushAndRemoveUntil(
              context,
              nextFadeInOutScreen(RoutingScreen.Main.route),
                  (route) => false,
            );
          },
          failure: (event) {
            Toast.showError(context, event.errorMessage);
          },
        );
      });
      return null;
    }, [signUpState, getMeState]);

    return BaseScaffold(
      appBar: TopBarIconTitleNone(
        content: Strings.of(context).commonSignUp,
        onBack: () => popPageWrapper(context: context),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 60),
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (socialJoinModel == null)
                  // Email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.of(context).commonEmail,
                          style: getTextTheme(context).b3m.copyWith(
                            color: getColorScheme(context).colorGray800,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: OutlineTextField.medium(
                            controller: useTextEditingController(),
                            hint: Strings.of(context).commonEmail,
                            successMessage: Strings.of(context).loginEmailCorrect,
                            errorMessage: Strings.of(context).loginEmailInvalid,
                            checkRegList: const [
                              RegCheckType.Email,
                            ],
                            onChanged: (text) => email.value = text,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),

                  if (socialJoinModel == null)
                  // Password
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.of(context).commonPassword,
                          style: getTextTheme(context).b3m.copyWith(
                            color: getColorScheme(context).colorGray800,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: OutlineTextField.medium(
                            controller: useTextEditingController(),
                            hint: Strings.of(context).commonPassword,
                            errorMessage: Strings.of(context).loginPwInvalid,
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
                        const SizedBox(height: 16),
                      ],
                    ),
                  // Full name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.of(context).commonFullName,
                        style: getTextTheme(context).b3m.copyWith(
                          color: getColorScheme(context).colorGray800,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: OutlineTextField.medium(
                          controller: useTextEditingController(),
                          hint: Strings.of(context).signupFullNameHint,
                          onChanged: (text) => fullName.value = text,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),

                  // Business name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.of(context).signupBusinessName,
                        style: getTextTheme(context).b3m.copyWith(
                          color: getColorScheme(context).colorGray800,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: OutlineTextField.medium(
                          controller: useTextEditingController(),
                          hint: Strings.of(context).signupBusinessNameHint,
                          onChanged: (text) => businessName.value = text,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: PrimaryFilledButton.mediumRound8(
                      content: Strings.of(context).commonSignUp,
                      isActivated: socialJoinModel == null
                          ? RegUtil.checkEmail(email.value) &&
                          email.value.isNotEmpty &&
                          RegUtil.checkPw(password.value) &&
                          password.value.isNotEmpty &&
                          fullName.value.isNotEmpty &&
                          businessName.value.isNotEmpty
                          : fullName.value.isNotEmpty && businessName.value.isNotEmpty,
                      onPressed: () async {
                        final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
                        Service.addHeader(key: HeaderKey.ApplicationTimeZone, value: timeZone);

                        if (socialJoinModel == null) {
                          signUpManager.requestMeJoin(
                            RequestMeJoinModel(
                              email: email.value,
                              name: fullName.value,
                              password: password.value,
                              business: businessName.value,
                              timeZone: timeZone,
                            ),
                          );
                        } else {
                          signUpManager.requestMeSocialJoin(
                            RequestMeSocialJoinModel(
                              type: socialJoinModel!.type,
                              accessToken: socialJoinModel!.accessToken,
                              name: fullName.value,
                              business: businessName.value,
                              timeZone: timeZone,
                            ),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            if (signUpState is Loading || getMeState is Loading) const LoadingView(),
          ],
        ),
      ),
    );
  }
}
