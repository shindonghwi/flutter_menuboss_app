import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/presentation/features/main/my/password/provider/PasswordChangeProvider.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleText.dart';
import 'package:menuboss_common/components/textfield/OutlineTextField.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/RegUtil.dart';
import 'package:menuboss_common/utils/UiState.dart';

class MyPasswordScreen extends HookConsumerWidget {
  const MyPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordChangeState = ref.watch(passwordChangeProvider);
    final passwordChangeManager = ref.read(passwordChangeProvider.notifier);

    final isPasswordChangedState = useState(false);
    final isFirstPasswordState = useState("");
    final isSecondPasswordState = useState("");

    useEffect(() {
      return () {
        Future(() {
          passwordChangeManager.init();
        });
      };
    }, []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        passwordChangeState.when(
          success: (event) async {
            Toast.showSuccess(context, getString(context).messagePasswordUpdateSuccess);
            Navigator.of(context).pop();
          },
          failure: (event) {
            Toast.showError(context, event.errorMessage);
          },
        );
      });
      return null;
    }, [passwordChangeState]);

    return BaseScaffold(
      appBar: TopBarIconTitleText(
        content: getString(context).myPagePasswordAppbarTitle,
        rightText: getString(context).commonSave,
        rightIconOnPressed: () {
          if (isPasswordChangedState.value) passwordChangeManager.requestChangePassword();
        },
        rightTextActivated: isPasswordChangedState.value,
        onBack: () => popPageWrapper(context: context),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 12),
                    child: Text(
                      getString(context).myPagePasswordNewPassword,
                      style: getTextTheme(context).b3m.copyWith(
                            color: getColorScheme(context).colorGray900,
                          ),
                    ),
                  ),
                  OutlineTextField.medium(
                    controller: useTextEditingController(text: ""),
                    hint: getString(context).myPagePasswordNewPassword,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.visiblePassword,
                    showPwVisibleButton: true,
                    showSuffixStatusIcon: false,
                    checkRegList: const [RegCheckType.PW],
                    errorMessage: getString(context).loginPwInvalid,
                    onChanged: (value) => isFirstPasswordState.value = value,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 12),
                    child: Text(
                      getString(context).myPagePasswordConfirmNewPassword,
                      style: getTextTheme(context).b3m.copyWith(
                            color: getColorScheme(context).colorGray900,
                          ),
                    ),
                  ),
                  OutlineTextField.medium(
                    controller: useTextEditingController(text: ""),
                    hint: getString(context).myPagePasswordConfirmNewPassword,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.visiblePassword,
                    showPwVisibleButton: true,
                    showSuffixStatusIcon: false,
                    checkRegList: const [RegCheckType.PW],
                    forceRedCheck: true,
                    errorMessage: isFirstPasswordState.value != isSecondPasswordState.value
                        ? getString(context).myPagePasswordConfirmError
                        : "",
                    onChanged: (value) {
                      isSecondPasswordState.value = value;
                      if (CollectionUtil.isNullEmptyFromString(isFirstPasswordState.value) ||
                          CollectionUtil.isNullEmptyFromString(isSecondPasswordState.value)) {
                        isPasswordChangedState.value = false;
                        return;
                      }
                      if (isFirstPasswordState.value == isSecondPasswordState.value) {
                        isPasswordChangedState.value = true;
                        passwordChangeManager.updatePassword(isSecondPasswordState.value);
                      } else {
                        isPasswordChangedState.value = false;
                      }
                    },
                  )
                ],
              ),
              if (passwordChangeState is Loading) const LoadingView()
            ],
          ),
        ),
      ),
    );
  }
}
