import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/schedule/ResponseScheduleModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarTitle.dart';
import 'package:menuboss/presentation/components/button/FloatingButton.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/ClickableScale.dart';
import 'package:menuboss/presentation/components/view_state/EmptyView.dart';
import 'package:menuboss/presentation/components/view_state/FailView.dart';
import 'package:menuboss/presentation/features/main/devices/provider/DeviceListProvider.dart';
import 'package:menuboss/presentation/features/main/schedules/provider/SchedulesProvider.dart';
import 'package:menuboss/presentation/features/main/schedules/widget/ScheduleItem.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../../../components/view_state/LoadingView.dart';

class SchedulesScreen extends HookConsumerWidget {
  const SchedulesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedulesState = ref.watch(schedulesProvider);
    final schedulesManager = ref.read(schedulesProvider.notifier);

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
            content: getAppLocalizations(context).main_navigation_menu_schedules,
          ),
          Expanded(
            child: Stack(
              children: [
                if (schedulesState is Failure)
                  FailView(onPressed: () => schedulesManager.requestGetSchedules())
                else if (schedulesState is Success<List<ResponseScheduleModel>>)
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
  final List<ResponseScheduleModel> items;

  const _ScheduleContentList({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceManager = ref.read(deviceListProvider.notifier);
    final scheduleProvider = ref.read(schedulesProvider.notifier);

    void goToCreateSchedule() async {
      try {
        final isUpdated = await Navigator.push(
          context,
          nextSlideVerticalScreen(
            RoutingScreen.CreateSchedule.route,
          ),
        );

        if (isUpdated) {
          scheduleProvider.requestGetSchedules();
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    void goToDetailSchedule(ResponseScheduleModel item) async {
      try {
        final isUpdated = await Navigator.push(
          context,
          nextSlideHorizontalScreen(
            RoutingScreen.DetailSchedule.route,
            parameter: item,
          ),
        );

        if (isUpdated) {
          deviceManager.requestGetDevices();
          scheduleProvider.requestGetSchedules();
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    return items.isNotEmpty
        ? Stack(
            children: [
              ListView.builder(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                physics: const BouncingScrollPhysics(),
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
              Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(bottom: 32, right: 24),
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
