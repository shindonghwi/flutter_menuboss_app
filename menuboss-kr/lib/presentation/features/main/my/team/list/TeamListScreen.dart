import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/data/models/business/ResponseBusinessMemberModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss_common/components/button/FloatingPlusButton.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/utils/ClickableScale.dart';
import 'package:menuboss_common/components/view_state/EmptyView.dart';
import 'package:menuboss_common/components/view_state/FailView.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/UiState.dart';

import 'provider/DelMemberProvider.dart';
import 'provider/TeamMemeberListProvider.dart';
import 'widget/TeamMemberItem.dart';

class TeamListScreen extends HookConsumerWidget {
  const TeamListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final delMemberState = ref.watch(delMemberProvider);
    final delMemberManager = ref.read(delMemberProvider.notifier);
    final teamMemberState = ref.watch(teamMemberListProvider);
    final teamMemberManager = ref.read(teamMemberListProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        teamMemberManager.requestGetTeamMember();
      });
      return () {
        Future(() {
          teamMemberManager.init();
          delMemberManager.init();
        });
      };
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          teamMemberState.when(
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [teamMemberState]);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          delMemberState.when(
            success: (event) {
              Toast.showSuccess(context, getString(context).messageRemoveMemberSuccess);
              teamMemberManager.removeMemberById(int.tryParse("${event.value}") ?? -1);
            },
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [delMemberState]);

    return BaseScaffold(
      appBar: TopBarIconTitleNone(
        content: getString(context).teamListAppbarTitle,
        onBack: () => popPageWrapper(context: context),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            if (teamMemberState is Failure)
              FailView(onPressed: () => teamMemberManager.requestGetTeamMember())
            else if (teamMemberState is Success<List<ResponseBusinessMemberModel>>)
              _TeamMemberContentList(items: teamMemberState.value),
            if (teamMemberState is Loading || delMemberState is Loading) const LoadingView(),
          ],
        ),
      ),
    );
  }
}

class _TeamMemberContentList extends HookConsumerWidget {
  final List<ResponseBusinessMemberModel> items;

  const _TeamMemberContentList({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamMemberManager = ref.read(teamMemberListProvider.notifier);
    final delMemberManager = ref.read(delMemberProvider.notifier);

    void goToCreateTeamMember({ResponseBusinessMemberModel? item}) async {
      try {
        final isUpdated = await Navigator.push(
          context,
          nextSlideHorizontalScreen(
            RoutingScreen.TeamCreate.route,
            parameter: item,
          ),
        );

        if (isUpdated) {
          teamMemberManager.requestGetTeamMember();
        }
      } catch (e) {}
    }

    return items.isNotEmpty
        ? Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  teamMemberManager.requestGetTeamMember(delay: 300);
                },
                color: getColorScheme(context).colorPrimary500,
                backgroundColor: getColorScheme(context).white,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ClickableScale(
                      child: TeamMemberItem(
                        item: item,
                        onDeleted: () => delMemberManager.removeMember(item.memberId),
                      ),
                      onPressed: () => goToCreateTeamMember(item: item),
                    );
                  },
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(bottom: 48, right: 24),
                child: FloatingPlusButton(
                  onPressed: () => goToCreateTeamMember(),
                ),
              )
            ],
          )
        : EmptyView(
            type: BlankMessageType.ADD_TEAM_MEMBER,
            onPressed: () => goToCreateTeamMember(),
          );
  }
}
