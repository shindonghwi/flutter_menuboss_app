import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/schedule/ResponseSchedulesModel.dart';
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
import 'package:menuboss_common/ui/Strings.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/UiState.dart';

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
            content: Strings.of(context).mainNavigationMenuSchedules,
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

    void goToCreateSchedule() {
      Navigator.push(
        context,
        nextSlideVerticalScreen(
          RoutingScreen.CreateSchedule.route,
        ),
      );
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
