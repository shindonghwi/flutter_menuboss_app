import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/business/RequestTeamMemberModel.dart';
import 'package:menuboss/data/models/business/ResponseBusinessMemberModel.dart';
import 'package:menuboss/data/models/business/ResponseBusinessMemberRole.dart';
import 'package:menuboss/data/models/business/ResponseRoleModel.dart';
import 'package:menuboss/domain/usecases/remote/business/GetRolesUseCase.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss_common/components/button/PrimaryFilledButton.dart';
import 'package:menuboss_common/components/dropdown/DropDownSelectButton.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/textfield/OutlineTextField.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/components/view_state/FailView.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/InputFormatterUtil.dart';
import 'package:menuboss_common/utils/RegUtil.dart';
import 'package:menuboss_common/utils/StringUtil.dart';
import 'package:menuboss_common/utils/UiState.dart';
import 'package:menuboss_common/utils/dto/Pair.dart';

import 'provider/RegisterOrUpdateMemberProvider.dart';

class TeamCreateScreen extends HookConsumerWidget {
  final ResponseBusinessMemberModel? item;

  const TeamCreateScreen({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerOrUpdateMemberState = ref.watch(registerOrUpdateMemberProvider);
    final registerOrUpdateMemberManager = ref.read(registerOrUpdateMemberProvider.notifier);

    final emailState = useState(item?.email ?? "");
    final nameState = useState(item?.name ?? "");
    final passwordState = useState("");
    final phoneState = useState(StringUtil.formatUsPhoneNumber(item?.phone?.phone ?? ""));
    final roleIdState = useState<int>(item?.role?.roleId ?? -1);
    final scrollController = useScrollController();

    useEffect(() {
      return () {
        Future(() {
          registerOrUpdateMemberManager.init();
        });
      };
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          registerOrUpdateMemberState.when(
            success: (event) {
              if (event.value) {
                Toast.showSuccess(context, getString(context).messageRegisterMemberSuccess);
              } else {
                Toast.showSuccess(context, getString(context).messageUpdateMemberSuccess);
              }
              Navigator.of(context).pop(true);
            },
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [registerOrUpdateMemberState]);

    return BaseScaffold(
      appBar: TopBarIconTitleNone(
        content: item == null
            ? getString(context).teamCreateAppbarCreateTitle
            : getString(context).teamCreateAppbarEditTitle,
        onBack: () => popPageWrapper(context: context),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  _Email(
                    initValue: item?.email ?? "",
                    onChanged: (email) => emailState.value = email,
                  ),
                  const SizedBox(height: 16),
                  _Name(
                    initValue: item?.name ?? "",
                    onChanged: (name) => nameState.value = name,
                  ),
                  const SizedBox(height: 16),
                  _Password(
                    onChanged: (password) => passwordState.value = password,
                  ),
                  const SizedBox(height: 16),
                  _InputPhoneNumber(
                    initValue: item?.phone?.phone ?? "",
                    onChanged: (countryName, countryCode, phone) => phoneState.value = phone,
                  ),
                  const SizedBox(height: 16),
                  _Role(
                    initValue: item?.role?.name ?? "",
                    roleModel: item?.role,
                    scrollController: scrollController,
                    onChanged: (roleId) => roleIdState.value = roleId,
                  ),
                ],
              ),
            ),
            if (registerOrUpdateMemberState is Loading) const LoadingView(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: PrimaryFilledButton.largeRound8(
            content: getString(context).commonSave,
            isActivated: RegUtil.checkEmail(emailState.value) &&
                nameState.value.isNotEmpty &&
                RegUtil.checkPw(passwordState.value) &&
                RegUtil.checkUsPhone(phoneState.value) &&
                roleIdState.value != -1,
            onPressed: () {
              registerOrUpdateMemberManager.updateMember(
                memberId: item?.memberId,
                model: RequestTeamMemberModel(
                  email: emailState.value,
                  name: nameState.value,
                  password: passwordState.value,
                  country: "US",
                  phone: "+1 ${StringUtil.extractNumbers(phoneState.value)}",
                  roleId: roleIdState.value,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Email extends HookWidget {
  final String initValue;
  final Function(String) onChanged;

  const _Email({
    super.key,
    required this.initValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getString(context).commonEmail,
          style: getTextTheme(context).b3m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.medium(
          controller: useTextEditingController(text: initValue),
          hint: getString(context).teamCreateEmailHint,
          successMessage: getString(context).loginEmailCorrect,
          errorMessage: getString(context).loginEmailInvalid,
          checkRegList: const [
            RegCheckType.Email,
          ],
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          onChanged: (value) => onChanged.call(value),
        ),
      ],
    );
  }
}

class _Name extends HookWidget {
  final String initValue;
  final Function(String) onChanged;

  const _Name({
    super.key,
    required this.initValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getString(context).commonFullName,
          style: getTextTheme(context).b3m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.medium(
          controller: useTextEditingController(text: initValue),
          hint: getString(context).teamCreateNameHint,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          onChanged: (value) => onChanged.call(value),
        ),
      ],
    );
  }
}

class _Password extends HookWidget {
  final Function(String) onChanged;

  const _Password({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getString(context).commonPassword,
          style: getTextTheme(context).b3m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.medium(
          controller: useTextEditingController(text: ""),
          hint: getString(context).teamCreatePasswordHint,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.visiblePassword,
          errorMessage: getString(context).loginPwInvalid,
          checkRegList: const [
            RegCheckType.PW,
          ],
          showPwVisibleButton: true,
          onChanged: (value) => onChanged.call(value),
        ),
      ],
    );
  }
}

class _InputPhoneNumber extends HookConsumerWidget {
  final String initValue;
  final Function(String countryName, String countryCode, String phone) onChanged;

  const _InputPhoneNumber({
    super.key,
    required this.initValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryList = [
      Pair("US", "+1"),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getString(context).commonPhoneNumber,
          style: getTextTheme(context).b3m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Flexible(
              flex: 10,
              fit: FlexFit.tight,
              child: Clickable(
                onPressed: () {},
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: getColorScheme(context).colorGray300,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const LoadSvg(
                            path: "assets/imgs/icon_us.svg",
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            countryList.first.second,
                            style: getTextTheme(context).b3m.copyWith(
                                  color: getColorScheme(context).colorGray900,
                                ),
                          )
                        ],
                      ),
                      LoadSvg(
                        path: "assets/imgs/icon_down.svg",
                        width: 20,
                        height: 20,
                        color: getColorScheme(context).colorGray600,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(flex: 1, fit: FlexFit.tight, child: Container()),
            Flexible(
              flex: 19,
              fit: FlexFit.tight,
              child: OutlineTextField.medium(
                inputFormatters: [InputFormatterUtil.usPhoneNumber()],
                controller: useTextEditingController(
                  text: StringUtil.formatUsPhoneNumber(initValue),
                ),
                hint: getString(context).myPageProfilePhoneHint,
                onChanged: (phoneNumber) {
                  onChanged.call(countryList.first.first, countryList.first.second, phoneNumber);
                },
              ),
            )
          ],
        )
      ],
    );
  }
}

class _Role extends HookWidget {
  final String initValue;
  final ResponseBusinessMemberRole? roleModel;
  final Function(int) onChanged;
  final ScrollController scrollController;

  const _Role({
    super.key,
    required this.initValue,
    required this.roleModel,
    required this.onChanged,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final futureRoles = useState<Future<ApiListResponse<List<ResponseRoleModel>>>?>(null);
    final roles = useState<List<ResponseRoleModel>?>([]);

    Future<ApiListResponse<List<ResponseRoleModel>>> requestGetRoles() async {
      final res = await GetIt.instance<GetRolesUseCase>().call();
      roles.value = [...res.list ?? []];
      onChanged.call(CollectionUtil.isNullorEmpty(roles.value) ? -1 : roles.value!.first.roleId);
      return res;
    }

    void refreshRoles() => futureRoles.value = requestGetRoles();

    useEffect(() {
      if (futureRoles.value == null) {
        refreshRoles();
      }
      return null;
    }, []);

    void handleDropdownClick() {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    }

    void goToCreateRole() async {
      final isCreated = await Navigator.push(
        context,
        nextSlideHorizontalScreen(
          RoutingScreen.RoleCreate.route,
        ),
      );

      if (isCreated) {
        refreshRoles();
      }
    }

    return FutureBuilder(
      future: futureRoles.value,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data?.status == 200) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getString(context).teamCreateRoleSelect,
                  style: getTextTheme(context).b3m.copyWith(
                    color: getColorScheme(context).colorGray900,
                  ),
                ),
                const SizedBox(height: 12),
                DropDownSelectButton.medium(
                  initialValue: initValue,
                  items: roles.value?.map((e) => e.name).toList() ?? [],
                  onOpened: (isOpened) {
                    if (CollectionUtil.isNullorEmpty(roles.value)) {
                      goToCreateRole();
                      return;
                    }
                    if (isOpened) handleDropdownClick();
                  },
                  onSelected: (int index, String text) {
                    final roleId = roles.value?[index].roleId;
                    onChanged.call(roleId ?? -1);
                  },
                )
              ],
            );
          } else {
            return FailView(onPressed: () => refreshRoles());
          }
        }
        return const SizedBox(
          width: double.infinity,
          height: 48,
          child: LoadingView(),
        );
      },
    );
  }
}
