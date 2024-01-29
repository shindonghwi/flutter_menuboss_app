import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/data/models/business/RequestRoleModel.dart';
import 'package:menuboss/data/models/business/ResponseRoleModel.dart';
import 'package:menuboss/data/models/business/ResponseRolePermissionModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss_common/components/button/NeutralLineButton.dart';
import 'package:menuboss_common/components/button/PrimaryFilledButton.dart';
import 'package:menuboss_common/components/textfield/OutlineTextField.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/UiState.dart';

import 'provider/RegisterOrUpdateRoleProvider.dart';

class RoleCreateScreen extends HookConsumerWidget {
  final ResponseRoleModel? item;

  const RoleCreateScreen({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerOrUpdateRoleState = ref.watch(registerOrUpdateRoleProvider);
    final registerOrUpdateRoleManager = ref.read(registerOrUpdateRoleProvider.notifier);

    final permissions = useMemoized(() {
      return item?.permissions
              ?.map((p) => ResponseRolePermissionModel(group: p.group, types: List.from(p.types)))
              .toList() ??
          [];
    }, [item]);

    bool evaluateInitialPermissions(List<ResponseRolePermissionModel> permissions) {
      for (var permission in permissions) {
        if (permission.types.isNotEmpty) {
          return true;
        }
      }
      return false;
    }

    final roleButtonState = useState<bool>(evaluateInitialPermissions(item?.permissions ?? []));
    final roleNameState = useState<String>(item?.name ?? "");
    final changedPermissionState = useState<List<ResponseRolePermissionModel>>(permissions);
    final isButtonActivated = useState<bool>(
      evaluateInitialPermissions(item?.permissions ?? []) && roleNameState.value.isNotEmpty,
    );

    useEffect(() {
      return () {
        Future(() {
          registerOrUpdateRoleManager.init();
        });
      };
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          registerOrUpdateRoleState.when(
            success: (event) {
              if (event.value) {
                Toast.showSuccess(context, getString(context).messageRegisterRoleSuccess);
              } else {
                Toast.showSuccess(context, getString(context).messageUpdateRoleSuccess);
              }
              Navigator.of(context).pop(true);
            },
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [registerOrUpdateRoleState]);

    return BaseScaffold(
      appBar: TopBarIconTitleNone(
        content: item == null
            ? getString(context).roleCreateAppbarCreateTitle
            : getString(context).roleCreateAppbarEditTitle,
        onBack: () => popPageWrapper(context: context),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  _RoleName(
                    initValue: item?.name ?? "",
                    onChanged: (name) {
                      roleNameState.value = name;
                      isButtonActivated.value = name.isNotEmpty && roleButtonState.value;
                    },
                  ),
                  _PermissionContainer(
                    permissionTypes: permissions,
                    onStatusChanged:
                        (bool isValid, List<ResponseRolePermissionModel> changedPermissions) {
                      roleButtonState.value = isValid;
                      isButtonActivated.value = isValid && roleNameState.value.isNotEmpty;
                      changedPermissionState.value = changedPermissions;
                    },
                  ),
                ],
              ),
            ),
            if (registerOrUpdateRoleState is Loading) const LoadingView(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: PrimaryFilledButton.largeRound8(
            onPressed: () {
              registerOrUpdateRoleManager.updateRole(
                roleId: item?.roleId,
                model: RequestRoleModel(
                  name: roleNameState.value,
                  permissions: changedPermissionState.value,
                ),
              );
            },
            content: getString(context).commonSave,
            isActivated: isButtonActivated.value,
          ),
        ),
      ),
    );
  }
}

class _RoleName extends HookWidget {
  final String initValue;
  final Function(String) onChanged;

  const _RoleName({
    super.key,
    required this.initValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getString(context).roleCreateName,
            style: getTextTheme(context).b3m.copyWith(
                  color: getColorScheme(context).colorGray900,
                ),
          ),
          const SizedBox(height: 12),
          OutlineTextField.medium(
            controller: useTextEditingController(text: initValue),
            hint: getString(context).roleCreateNameHint,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.text,
            onChanged: (value) => onChanged.call(value),
          ),
        ],
      ),
    );
  }
}

class _PermissionContainer extends HookWidget {
  final List<ResponseRolePermissionModel> permissionTypes;
  final void Function(bool, List<ResponseRolePermissionModel>)
      onStatusChanged; // Callback parameter

  const _PermissionContainer({
    super.key,
    required this.permissionTypes,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final allGroups = ['Canvas', 'Screens', 'Playlists', 'Schedules', 'Media'];

    final permissionsState = useState<Map<String, List<String>>>(
      permissionTypes.isEmpty
          ? {for (var group in allGroups) group: []}
          : {for (var model in permissionTypes) model.group: model.types},
    );

    void updatePermission(String group, String permission, bool isAdded) {
      permissionsState.value = Map.from(permissionsState.value);
      final currentPermissions = permissionsState.value[group] ?? [];

      if (isAdded) {
        currentPermissions.add(permission);
      } else {
        currentPermissions.remove(permission);
      }
      permissionsState.value[group] = currentPermissions;
      bool isValid = permissionsState.value.values.every((permissions) => permissions.isNotEmpty);

      List<ResponseRolePermissionModel> changedPermissionModel =
          permissionsState.value.entries.map((e) {
        String group = e.key;
        List<String> types = e.value;
        return ResponseRolePermissionModel(group: group, types: types);
      }).toList();

      onStatusChanged(isValid, changedPermissionModel);
    }

    String getTitle(String group) {
      String type = group.toLowerCase();
      if (type.contains("canvas")) {
        return getString(context).commonCanvas;
      } else if (type.contains("screen")) {
        return getString(context).mainNavigationMenuScreens;
      } else if (type.contains("playlist")) {
        return getString(context).mainNavigationMenuPlaylists;
      } else if (type.contains("schedule")) {
        return getString(context).mainNavigationMenuSchedules;
      } else if (type.contains("media")) {
        return getString(context).mainNavigationMenuMedia;
      } else {
        return "";
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            getString(context).commonPermission,
            style: getTextTheme(context).b3sb.copyWith(
                  color: getColorScheme(context).colorGray700,
                ),
          ),
          const SizedBox(height: 24),
          ...allGroups.map((group) {
            String title = getTitle(group);
            List<String> types = permissionsState.value[group] ?? [];

            return _PermissionContent(
              key: UniqueKey(), // Continue using unique keys
              title: title,
              permissionTypes: types,
              onPermissionChanged: (permission, isAdded) {
                updatePermission(group, permission, isAdded);
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}

class _PermissionContent extends HookWidget {
  final String title;
  final List<String> permissionTypes;
  final Function(String, bool) onPermissionChanged;

  const _PermissionContent({
    super.key,
    required this.title,
    required this.permissionTypes,
    required this.onPermissionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final allPermissionTypes = ['Read', 'Create', 'Delete', 'Edit'];

    final activatedPermissions = useState<List<bool>>(
      permissionTypes.isEmpty
          ? List.filled(allPermissionTypes.length, false)
          : allPermissionTypes.map((type) => permissionTypes.contains(type)).toList(),
    );

    String translatePermission(String permission) {
      switch (permission) {
        case 'Read':
          return getString(context).commonPermissionRead;
        case 'Create':
          return getString(context).commonPermissionCreate;
        case 'Edit':
          return getString(context).commonPermissionEdit;
        case 'Delete':
          return getString(context).commonPermissionDelete;
        default:
          return permission;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: getTextTheme(context).b3sb.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 16),
        Row(
          children: allPermissionTypes
              .asMap()
              .entries
              .map((entry) {
                int index = entry.key;
                String permission = translatePermission(entry.value);
                bool isActivated = activatedPermissions.value[index];

                return Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: isActivated
                      ? PrimaryFilledButton.smallRound100(
                          content: permission,
                          isActivated: true,
                          onPressed: () {
                            bool newStatus = !activatedPermissions.value[index];
                            activatedPermissions.value = List.from(activatedPermissions.value)
                              ..[index] = newStatus;
                            onPermissionChanged(allPermissionTypes[index], newStatus);
                          },
                        )
                      : NeutralLineButton.smallRound100(
                          content: permission,
                          isActivated: true,
                          onPressed: () {
                            bool newStatus = !activatedPermissions.value[index];
                            activatedPermissions.value = List.from(activatedPermissions.value)
                              ..[index] = newStatus;
                            onPermissionChanged(allPermissionTypes[index], newStatus);
                          },
                        ),
                );
              })
              .expand((widget) => [widget, const SizedBox(width: 8)])
              .toList()
            ..removeLast(),
        ),
        SizedBox(height: 24)
      ],
    );
  }
}
