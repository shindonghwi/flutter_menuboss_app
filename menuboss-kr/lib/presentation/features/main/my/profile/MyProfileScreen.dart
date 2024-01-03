import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/features/login/provider/MeInfoProvider.dart';
import 'package:menuboss/presentation/features/main/my/profile/provider/NameChangeProvider.dart';
import 'package:menuboss/presentation/features/main/my/profile/provider/PostProfileImageUploadProvider.dart';
import 'package:menuboss/presentation/features/main/my/profile/provider/UpdateProfileImageProvider.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleText.dart';
import 'package:menuboss_common/components/loader/LoadProfile.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/placeholder/PlaceholderType.dart';
import 'package:menuboss_common/components/textfield/OutlineTextField.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/Strings.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/FilePickerUtil.dart';
import 'package:menuboss_common/utils/UiState.dart';

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
        content: Strings.of(context).myPageProfileAppbarTitle,
        rightText: Strings.of(context).commonSave,
        rightIconOnPressed: () {
          nameChangeManager.requestChangeName();
        },
        rightTextActivated: isNameChangedState.value,
        onBack: () => popPageWrapper(context: context),
      ),
      backgroundColor: getColorScheme(context).white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Align(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
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
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
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
                            padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
                            child: Text(
                              Strings.of(context).myPageProfileDeleteAccount,
                              style: getTextTheme(context).b3m.copyWith(
                                    color: getColorScheme(context).colorGray600,
                                  ),
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
                Toast.showSuccess(context, Strings.of(context).messageFileNotAllowed404);
              },
              onError: (message) {
                Toast.showError(context, message);
              },
              errorPermissionMessage: Strings.of(context).messagePermissionErrorPhotos,
            );
          },
          borderRadius: 100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: LoadSvg(
              path: "assets/imgs/icon_picture.svg",
              width: 16,
              height: 16,
              color: getColorScheme(context).white,
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
          Strings.of(context).commonFullName,
          style: getTextTheme(context).b3m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.medium(
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
          Strings.of(context).commonEmail,
          style: getTextTheme(context).b3m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.medium(
          hint: meInfoState?.email ?? "",
          enable: false,
        )
      ],
    );
  }
}
