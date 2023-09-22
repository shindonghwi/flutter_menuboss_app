import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleText.dart';
import 'package:menuboss/presentation/components/loader/LoadProfile.dart';
import 'package:menuboss/presentation/components/placeholder/ProfilePlaceholder.dart';
import 'package:menuboss/presentation/components/textfield/OutlineTextField.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/features/login/provider/MeInfoProvider.dart';
import 'package:menuboss/presentation/features/main/my/profile/provider/NameChangeProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class MyProfileScreen extends HookConsumerWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final nameChangeState = ref.watch(NameChangeProvider);
    final meInfoProvider = ref.read(MeInfoProvider.notifier);
    final nameChangeProvider = ref.read(NameChangeProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        nameChangeState.when(
          success: (event) async {
            meInfoProvider.updateMeFullName(nameChangeProvider.getName());
            nameChangeProvider.init();
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
          nameChangeProvider.requestChangeName();
        },
        rightTextActivated: true,
      ),
      backgroundColor: getColorScheme(context).white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
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
                          url: "https://img.freepik.com/free-photo/portrait-of-white-man-isolated_53876-40306.jpg",
                          type: ProfileImagePlaceholderType.Size120x120,
                        ),
                        _CameraWidget()
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 32, bottom: 40),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InputFullName(),
                      SizedBox(height: 24),
                      _InputEmail(),
                    ],
                  ),
                )
              ],
            ),
          ),
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

    final nameChangeProvider = ref.read(NameChangeProvider.notifier);

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
          controller: useTextEditingController(),
          hint: "John Doe",
          onChanged: (value) => nameChangeProvider.updateName(value),
        )
      ],
    );
  }
}

class _InputEmail extends HookWidget {
  const _InputEmail({super.key});

  @override
  Widget build(BuildContext context) {
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
          controller: useTextEditingController(),
          hint: "John Doe",
          enable: false,
        )
      ],
    );
  }
}