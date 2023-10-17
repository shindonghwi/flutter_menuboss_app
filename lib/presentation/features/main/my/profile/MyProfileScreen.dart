// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleText.dart';
import 'package:menuboss/presentation/components/divider/DividerVertical.dart';
import 'package:menuboss/presentation/components/loader/LoadProfile.dart';
import 'package:menuboss/presentation/components/placeholder/ProfilePlaceholder.dart';
import 'package:menuboss/presentation/components/textfield/OutlineTextField.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/components/view_state/LoadingView.dart';
import 'package:menuboss/presentation/features/login/provider/MeInfoProvider.dart';
import 'package:menuboss/presentation/features/main/my/profile/provider/NameChangeProvider.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class MyProfileScreen extends HookConsumerWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameChangeState = ref.watch(nameChangeProvider);
    final meInfoManager = ref.read(meInfoProvider.notifier);
    final nameChangeManager = ref.read(nameChangeProvider.notifier);

    useEffect(() {
      return (){
        Future((){
          nameChangeManager.init();
        });
      };
    },[]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        nameChangeState.when(
          success: (event) async {
            meInfoManager.updateMeFullName(nameChangeManager.getName());
            Navigator.of(context).pop();
          },
          failure: (event) {
            Toast.showError(context, event.errorMessage);
          },
        );
      });
      return null;
    }, [nameChangeState]);

    return BaseScaffold(
      appBar: TopBarIconTitleText(
        content: getAppLocalizations(context).my_page_profile_appbar_title,
        rightText: getAppLocalizations(context).common_save,
        rightIconOnPressed: () {
          nameChangeManager.requestChangeName();
        },
        rightTextActivated: true,
      ),
      backgroundColor: getColorScheme(context).white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  const Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: Stack(
                        children: [
                          LoadProfile(
                            url: "",
                            type: ProfileImagePlaceholderType.Size120x120,
                          ),
                          _CameraWidget()
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _InputFullName(),
                        SizedBox(height: 24),
                        _InputEmail(),
                      ],
                    ),
                  ),
                  const DividerVertical(marginVertical: 0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Clickable(
                        onPressed: () {
                          Navigator.push(
                            context,
                            nextSlideHorizontalScreen(
                              RoutingScreen.DeleteAccount.route,
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            getAppLocalizations(context).my_page_profile_delete_account,
                            style: getTextTheme(context).b3sb.copyWith(
                                  color: getColorScheme(context).colorGray900,
                                ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (nameChangeState is Loading) const LoadingView()
          ],
        ),
      ),
    );
  }
}

class _CameraWidget extends StatelessWidget {
  const _CameraWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: getColorScheme(context).colorPrimary500,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Clickable(
          onPressed: () {},
          borderRadius: 100,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              "assets/imgs/icon_picture.svg",
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                getColorScheme(context).white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InputFullName extends HookConsumerWidget {
  const _InputFullName({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meInfoManager = ref.watch(meInfoProvider);
    final nameChangeManager = ref.read(nameChangeProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getAppLocalizations(context).my_page_profile_full_name,
          style: getTextTheme(context).b1sb.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.small(
          controller: useTextEditingController(text: meInfoManager?.profile?.name),
          hint: meInfoManager?.profile?.name ?? "",
          onChanged: (value) => nameChangeManager.updateName(value),
        )
      ],
    );
  }
}

class _InputEmail extends HookConsumerWidget {
  const _InputEmail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meInfoManager = ref.watch(meInfoProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${getAppLocalizations(context).common_email} ${getAppLocalizations(context).common_address}",
          style: getTextTheme(context).b1sb.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.small(
          hint: meInfoManager?.email ?? "",
          enable: false,
        )
      ],
    );
  }
}
