import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/features/login/provider/MeInfoProvider.dart';
import 'package:menuboss/presentation/features/main/my/profile/provider/LeaveAccountProvider.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss_common/components/button/PrimaryFilledButton.dart';
import 'package:menuboss_common/components/checkbox/radio/BasicBorderRadioButton.dart';
import 'package:menuboss_common/components/popup/CommonPopup.dart';
import 'package:menuboss_common/components/popup/PopupDeleteAccount.dart';
import 'package:menuboss_common/components/textarea/DefaultTextArea.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/utils/ClickableScale.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/strings.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/UiState.dart';
import 'package:menuboss_common/utils/dto/Pair.dart';

class DeleteAccountScreen extends HookConsumerWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meInfoManager = ref.read(meInfoProvider.notifier);
    final leaveAccountState = ref.watch(leaveAccountProvider);
    final leaveAccountManager = ref.read(leaveAccountProvider.notifier);

    final isShowFirstDescription = useState(true);
    final reasons = [
      Pair(Strings.of(context).deleteAccountReasonMenu1, useState(false)),
      Pair(Strings.of(context).deleteAccountReasonMenu2, useState(false)),
      Pair(Strings.of(context).deleteAccountReasonMenu3, useState(false)),
      Pair(Strings.of(context).deleteAccountReasonMenu4, useState(false)),
    ];

    final otherReasonText = useState("");
    final otherTextController = useTextEditingController(text: otherReasonText.value);

    void goToLogin() {
      meInfoManager.updateMeInfo(null);
      Future.delayed(const Duration(milliseconds: 300), () {
        Navigator.pushAndRemoveUntil(
          context,
          nextFadeInOutScreen(RoutingScreen.Login.route),
          (route) => false,
        );
      });
    }

    useEffect(() {
      otherTextController.text = otherReasonText.value;
      return () {
        otherTextController.dispose;
      };
    }, [otherReasonText.value]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        leaveAccountState.when(
          success: (event) async {
            leaveAccountManager.init();
            CommonPopup.showPopup(
              context,
              child: PopupDeleteAccount(
                onClicked: (value) {
                  goToLogin();
                },
              ),
              barrierDismissible: false,
            );
          },
          failure: (event) {
            Toast.showError(context, event.errorMessage);
          },
        );
      });
      return null;
    }, [leaveAccountState]);

    return BaseScaffold(
      appBar: TopBarIconTitleNone(
        content: Strings.of(context).deleteAccountTitle,
        onBack: () => popPageWrapper(context: context),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                firstChild: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        Strings.of(context).deleteAccountDescription,
                        style: getTextTheme(context).s3sb.copyWith(
                              color: getColorScheme(context).colorGray900,
                            ),
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        Strings.of(context).deleteAccountDescription1,
                        style: getTextTheme(context).b2m.copyWith(
                              color: getColorScheme(context).colorGray700,
                            ),
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                secondChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      Strings.of(context).deleteAccountReasonTitle,
                      style: getTextTheme(context).s3sb.copyWith(
                            color: getColorScheme(context).colorGray900,
                          ),
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      children: reasons.map((item) {
                        final reason = item.first;
                        final isSelectNotifier = item.second;

                        return ClickableScale(
                          onPressed: () {
                            for (var element in reasons) {
                              if (element.first != reason) {
                                element.second.value = false;
                              } else {
                                isSelectNotifier.value = !isSelectNotifier.value;
                                if (element.first == reasons.last.first) {
                                  leaveAccountManager.currentReason = otherTextController.text;
                                } else {
                                  leaveAccountManager.currentReason = reason;
                                }
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: BasicBorderRadioButton(
                                    isChecked: isSelectNotifier.value,
                                    onChange: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Text(
                                    reason,
                                    style: getTextTheme(context).b2m.copyWith(
                                          color: getColorScheme(context).colorGray700,
                                        ),
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    if (reasons.last.second.value)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: DefaultTextArea.normal(
                          controller: otherTextController,
                          hint: Strings.of(context).deleteAccountReasonMenu4Hint,
                          onChanged: (value) {
                            leaveAccountManager.currentReason = value;
                          },
                        ),
                      ),
                  ],
                ),
                crossFadeState: isShowFirstDescription.value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              ),
            ),
            if (leaveAccountState is Loading) const LoadingView()
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: PrimaryFilledButton.mediumRound8(
              content: isShowFirstDescription.value
                  ? Strings.of(context).commonNext
                  : Strings.of(context).deleteAccountTitle,
              isActivated: true,
              onPressed: () {
                if (isShowFirstDescription.value) {
                  isShowFirstDescription.value = false;
                } else {
                  leaveAccountManager.requestMeLeave();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
