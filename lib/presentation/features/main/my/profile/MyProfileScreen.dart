import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleText.dart';
import 'package:menuboss/presentation/components/loader/LoadProfile.dart';
import 'package:menuboss/presentation/components/placeholder/ProfilePlaceholder.dart';
import 'package:menuboss/presentation/components/textfield/OutlineTextField.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/components/view_state/LoadingView.dart';
import 'package:menuboss/presentation/features/login/provider/MeInfoProvider.dart';
import 'package:menuboss/presentation/features/main/my/profile/provider/NameChangeProvider.dart';
import 'package:menuboss/presentation/features/main/my/profile/provider/PostProfileImageUploadProvider.dart';
import 'package:menuboss/presentation/features/main/my/profile/provider/UpdateProfileImageProvider.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/FilePickerUtil.dart';

class MyProfileScreen extends HookConsumerWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameChangeState = ref.watch(nameChangeProvider);
    final nameChangeManager = ref.read(nameChangeProvider.notifier);

    final updateProfileImageState = ref.watch(updateProfileImageProvider);
    final updateProfileImageManager = ref.read(updateProfileImageProvider.notifier);

    final uploadState = ref.watch(postProfileImageUploadProvider);
    final uploadManager = ref.read(postProfileImageUploadProvider.notifier);

    final meInfoState = ref.watch(meInfoProvider);
    final meInfoManager = ref.read(meInfoProvider.notifier);

    final isNameChangedState = useState(false);

    useEffect(() {
      return () {
        Future(() {
          nameChangeManager.init();
          updateProfileImageManager.init();
          uploadManager.init();
        });
      };
    }, []);

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
    }, [nameChangeState, updateProfileImageState]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        uploadState.when(
          success: (event) async {
            updateProfileImageManager.requestUploadProfileImage(uploadManager.imageId);
            updateProfileImageManager.init();
          },
          failure: (event) {
            Toast.showError(context, event.errorMessage);
          },
        );
      });
      return null;
    }, [uploadState]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        updateProfileImageState.when(
          success: (event) async {
            meInfoManager.updateMeProfileImage(event.value ?? "");
            updateProfileImageManager.init();
            uploadManager.init();
          },
          failure: (event) {
            Toast.showError(context, event.errorMessage);
          },
        );
      });
      return null;
    }, [updateProfileImageState]);

    return BaseScaffold(
      appBar: TopBarIconTitleText(
        content: getAppLocalizations(context).my_page_profile_appbar_title,
        rightText: getAppLocalizations(context).common_save,
        rightIconOnPressed: () {
          nameChangeManager.requestChangeName();
        },
        rightTextActivated: isNameChangedState.value,
      ),
      backgroundColor: getColorScheme(context).white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: Stack(
                        children: [
                          LoadProfile(
                            url: meInfoState?.profile?.imageUrl ?? "",
                            type: ProfileImagePlaceholderType.Size120x120,
                          ),
                          const _CameraWidget()
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _InputFullName(
                          isNameChanged: (value) {
                            isNameChangedState.value = value;
                          },
                        ),
                        const SizedBox(height: 24),
                        const _InputEmail(),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.all(24),
                      child: Clickable(
                        onPressed: () {
                          Navigator.push(
                            context,
                            nextSlideHorizontalScreen(
                              RoutingScreen.DeleteAccount.route,
                            ),
                          );
                        },
                        child: Text(
                          getAppLocalizations(context).my_page_profile_delete_account,
                          style: getTextTheme(context).b3m.copyWith(
                                color: getColorScheme(context).colorGray600,
                              ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (nameChangeState is Loading || uploadState is Loading || updateProfileImageState is Loading)
              const LoadingView()
          ],
        ),
      ),
    );
  }
}

class _CameraWidget extends HookConsumerWidget {
  const _CameraWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadManager = ref.read(postProfileImageUploadProvider.notifier);

    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: getColorScheme(context).colorGray600,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Clickable(
          onPressed: () {
            FilePickerUtil.pickFile(
              onImageSelected: (XFile xFile) async {
                uploadManager.requestUploadProfileImage(xFile.path);
              },
              onVideoSelected: null,
              notAvailableFile: () {
                Toast.showSuccess(context, getAppLocalizations(context).message_file_not_allow_404);
              },
              onError: (message) {
                Toast.showError(context, message);
              },
            );
          },
          borderRadius: 100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              "assets/imgs/icon_picture.svg",
              width: 16,
              height: 16,
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
  final Function(bool) isNameChanged;

  const _InputFullName({
    super.key,
    required this.isNameChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meInfoState = ref.watch(meInfoProvider);
    final nameChangeManager = ref.read(nameChangeProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getAppLocalizations(context).common_full_name,
          style: getTextTheme(context).b3m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.small(
          controller: useTextEditingController(text: meInfoState?.profile?.name),
          hint: meInfoState?.profile?.name ?? "",
          onChanged: (value) {
            isNameChanged(value != meInfoState?.profile?.name);
            nameChangeManager.updateName(value);
          },
        )
      ],
    );
  }
}

class _InputEmail extends HookConsumerWidget {
  const _InputEmail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meInfoState = ref.watch(meInfoProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getAppLocalizations(context).common_email,
          style: getTextTheme(context).b3m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.small(
          hint: meInfoState?.email ?? "",
          enable: false,
        )
      ],
    );
  }
}
