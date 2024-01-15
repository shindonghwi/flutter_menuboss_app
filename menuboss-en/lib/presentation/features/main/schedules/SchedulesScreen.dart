import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/data/models/schedule/ResponseSchedulesModel.dart';
import 'package:menuboss/domain/usecases/local/app/GetTutorialViewedUseCase.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/features/main/schedules/provider/SchedulesProvider.dart';
import 'package:menuboss/presentation/features/main/schedules/widget/ScheduleItem.dart';
import 'package:menuboss_common/components/appbar/TopBarTitle.dart';
import 'package:menuboss_common/components/button/FloatingPlusButton.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/ClickableScale.dart';
import 'package:menuboss_common/components/view_state/EmptyView.dart';
import 'package:menuboss_common/components/view_state/FailView.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/tutorial/model/TutorialKey.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/UiState.dart';

import '../widget/provider/TutorialProvider.dart';

class SchedulesScreen extends HookConsumerWidget {
  const SchedulesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedulesState = ref.watch(schedulesProvider);
    final schedulesManager = ref.read(schedulesProvider.notifier);

    useEffect(() {
      return () {
        Future(() {
          schedulesManager.init();
        });
      };
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          schedulesState.when(
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        handleUiStateChange();
      });
      return null;
    }, [schedulesState]);

    return SafeArea(
      child: Column(
        children: [
          TopBarTitle(
            content: getString(context).mainNavigationMenuSchedules,
          ),
          Expanded(
            child: Stack(
              children: [
                if (schedulesState is Failure)
                  FailView(onPressed: () => schedulesManager.requestGetSchedules())
                else if (schedulesState is Success<List<ResponseSchedulesModel>>)
                  _ScheduleContentList(items: schedulesState.value),
                if (schedulesState is Loading) const LoadingView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleContentList extends HookConsumerWidget {
  final List<ResponseSchedulesModel> items;

  const _ScheduleContentList({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedulesManager = ref.read(schedulesProvider.notifier);
    final getTutorialViewedUseCase = GetIt.instance<GetTutorialViewedUseCase>();
    final tutorialManager = ref.read(tutorialProvider.notifier);

    void goToCreateSchedule() async {
      final isAdded = await Navigator.push(
        context,
        nextSlideVerticalScreen(
          RoutingScreen.CreateSchedule.route,
        ),
      );

      if (isAdded) {
        bool hasViewed = await getTutorialViewedUseCase.call(TutorialKey.ScheduleAddedKey);
        if (!hasViewed) {
          tutorialManager.change(TutorialKey.ScheduleAddedKey, 1.0);
        }
      }
    }

    void goToDetailSchedule(ResponseSchedulesModel item) {
      Navigator.push(
        context,
        nextSlideHorizontalScreen(
          RoutingScreen.DetailSchedule.route,
          parameter: item,
        ),
      );
    }

    return items.isNotEmpty
        ? Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  schedulesManager.requestGetSchedules(delay: 300);
                },
                color: getColorScheme(context).colorPrimary500,
                backgroundColor: getColorScheme(context).white,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ClickableScale(
                      child: ScheduleItem(item: item),
                      onPressed: () => goToDetailSchedule(item),
                    );
                  },
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(bottom: 16, right: 24),
                child: FloatingPlusButton(
                  onPressed: () => goToCreateSchedule(),
                ),
              )
            ],
          )
        : EmptyView(
            type: BlankMessageType.NEW_SCHEDULE,
            onPressed: () => goToCreateSchedule(),
          );
  }
}
