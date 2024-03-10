import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/app/env/Environment.dart';
import 'package:menuboss/data/models/me/RequestMeSocialJoinModel.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss_common/components/button/PrimaryFilledButton.dart';
import 'package:menuboss_common/components/checkbox/checkbox/BasicBorderCheckBox.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../navigation/PageMoveUtil.dart';
import '../../../navigation/Route.dart';

class PolicyScreen extends HookWidget {
  final RequestMeSocialJoinModel? socialJoinModel;
  final String? socialEmail;

  const PolicyScreen({
    super.key,
    this.socialJoinModel,
    this.socialEmail,
  });

  @override
  Widget build(BuildContext context) {
    final isButtonActivated = useState(false);

    return BaseScaffold(
      appBar: TopBarIconTitleNone(
        content: getString(context).policyTitle,
        onBack: () => popPageWrapper(context: context),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _TitleContent(),
          const SizedBox(height: 32),
          _TermContents(isAgreedCallback: (value) {
            debugPrint("isAgreedCallback: $value");
            isButtonActivated.value = value;
          }),
        ],
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: PrimaryFilledButton.largeRound8(
          content: getString(context).commonNext,
          isActivated: isButtonActivated.value,
          onPressed: () {
            Navigator.push(
              context,
              nextSlideHorizontalScreen(
                RoutingScreen.SignUp.route,
                parameter: socialJoinModel,
                parameter1: socialEmail,
              ),
            );
          },
        ),
      )),
    );
  }
}

class _TitleContent extends StatelessWidget {
  const _TitleContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getString(context).policyDescriptionTitle,
            style: getTextTheme(context).s1sb.copyWith(
                  color: getColorScheme(context).colorGray900,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            getString(context).policyDescription,
            style: getTextTheme(context).b2m.copyWith(
                  color: getColorScheme(context).colorGray700,
                  overflow: TextOverflow.visible,
                ),
          ),
        ],
      ),
    );
  }
}

class _TermContents extends HookWidget {
  final Function(bool) isAgreedCallback;

  const _TermContents({
    super.key,
    required this.isAgreedCallback,
  });

  @override
  Widget build(BuildContext context) {
    final allAgree = useState(false);

    var termAgreeList = [
      useState(false),
      useState(false),
      useState(false),
      useState(false),
    ];

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // 개별 체크박스의 상태가 변경될 때만 전체동의 체크박스 상태를 업데이트합니다.
        final areAllTermsAgreed = termAgreeList.every((term) => term.value);
        if (allAgree.value != areAllTermsAgreed) {
          allAgree.value = areAllTermsAgreed;
        }
        isAgreedCallback.call(
          termAgreeList[0].value && termAgreeList[1].value && termAgreeList[2].value,
        );
      });
      return null;
    }, [...termAgreeList.map((term) => term.value)]);

    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Clickable(
            onPressed: () {
              termAgreeList = [
                ...termAgreeList.map((term) => term..value = !allAgree.value),
              ];
            },
            child: Row(
              children: [
                IgnorePointer(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BasicBorderCheckBox(
                      borderRadius: 4,
                      isChecked: allAgree.value,
                      onChange: (_) {},
                    ),
                  ),
                ),
                Text(
                  getString(context).commonAllAgree,
                  style: getTextTheme(context).b2sb.copyWith(
                        color: getColorScheme(context).colorGray900,
                      ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            height: 1,
            color: getColorScheme(context).colorGray200,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: termAgreeList.asMap().entries.map((e) {
              int index = e.key;
              ValueNotifier<bool> value = e.value;
              String content = "";
              String policyBaseUrl = Environment.prodWebUrl;
              String policyFullUrl = "";

              if (index == 0) {
                content = getString(context).policyTerm1;
              } else if (index == 1) {
                content = getString(context).policyTerm2;
                policyFullUrl = "$policyBaseUrl/policy/service";
              } else if (index == 2) {
                content = getString(context).policyTerm3;
                policyFullUrl = "$policyBaseUrl/policy/privacy";
              } else if (index == 3) {
                content = getString(context).policyTerm4;
                policyFullUrl = "$policyBaseUrl/policy/marketing";
              }

              return SizedBox(
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Clickable(
                        onPressed: () => value.value = !value.value,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IgnorePointer(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BasicBorderCheckBox(
                                  borderRadius: 4,
                                  isChecked: value.value,
                                  onChange: (_) {},
                                ),
                              ),
                            ),
                            Text(
                              content,
                              style: getTextTheme(context).b3m.copyWith(
                                    color: getColorScheme(context).colorGray700,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (!CollectionUtil.isNullEmptyFromString(policyFullUrl))
                      Clickable(
                        onPressed: () => launchUrlString(policyFullUrl),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LoadSvg(
                            path: "assets/imgs/icon_next.svg",
                            width: 18,
                            height: 18,
                            color: getColorScheme(context).colorGray500,
                          ),
                        ),
                      )
                  ],
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
