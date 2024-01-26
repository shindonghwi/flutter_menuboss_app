import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/data/models/business/ResponseBusinessMemberModel.dart';
import 'package:menuboss/data/models/business/ResponseRoleModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss_common/components/button/FloatingPlusButton.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/utils/ClickableScale.dart';
import 'package:menuboss_common/components/view_state/EmptyView.dart';
import 'package:menuboss_common/components/view_state/EmptyView.dart';
import 'package:menuboss_common/components/view_state/FailView.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/UiState.dart';

import 'provider/RoleListProvider.dart';
import 'widget/RoleItem.dart';

class RoleListScreen extends HookConsumerWidget {
  const RoleListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleListState = ref.watch(roleListProvider);
    final roleListManager = ref.read(roleListProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        roleListManager.requestGetRoles();
      });
      return () {
        Future(() {
          roleListManager.init();
        });
      };
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          roleListState.when(
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [roleListState]);

    return BaseScaffold(
      appBar: TopBarIconTitleNone(
        content: getString(context).roleListAppbarTitle,
        onBack: () => popPageWrapper(context: context),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            if (roleListState is Failure)
              FailView(onPressed: () => roleListManager.requestGetRoles())
            else if (roleListState is Success<List<ResponseRoleModel>>)
              _RoleContentList(items: roleListState.value),
            if (roleListState is Loading) const LoadingView(),
          ],
        ),
      ),
    );
  }
}

class _RoleContentList extends HookConsumerWidget {
  final List<ResponseRoleModel> items;

  const _RoleContentList({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleListManager = ref.read(roleListProvider.notifier);

    void goToCreateRole({ResponseRoleModel? item}) async {
      Navigator.push(
        context,
        nextSlideHorizontalScreen(
          RoutingScreen.RoleCreate.route,
          parameter: item,
        ),
      );
    }

    return items.isNotEmpty
        ? Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  roleListManager.requestGetRoles(delay: 300);
                },
                color: getColorScheme(context).colorPrimary500,
                backgroundColor: getColorScheme(context).white,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ClickableScale(
                      child: RoleItem(item: item),
                      onPressed: () => goToCreateRole(item: item),
                    );
                  },
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(bottom: 48, right: 24),
                child: FloatingPlusButton(
                  onPressed: () => goToCreateRole(),
                ),
              )
            ],
          )
        : EmptyView(
            type: BlankMessageType.ADD_ROLE,
            onPressed: () => goToCreateRole(),
          );
  }
}
