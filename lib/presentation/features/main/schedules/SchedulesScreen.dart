import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/schedule/ResponseScheduleModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarTitle.dart';
import 'package:menuboss/presentation/components/blank/BlankMessage.dart';
import 'package:menuboss/presentation/components/button/FloatingButton.dart';
import 'package:menuboss/presentation/components/loading/LoadingView.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/utils/ClickableScale.dart';
import 'package:menuboss/presentation/features/main/devices/provider/DeviceListProvider.dart';
import 'package:menuboss/presentation/features/main/schedules/provider/SchedulesProvider.dart';
import 'package:menuboss/presentation/features/main/schedules/widget/ScheduleItem.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class SchedulesScreen extends HookConsumerWidget {
  const SchedulesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleItems = useState<List<ResponseScheduleModel>?>(null);
    final schedulesState = ref.watch(SchedulesProvider);
    final schedulesProvider = ref.read(SchedulesProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        schedulesProvider.requestGetSchedules();
      });
      return null;
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          schedulesState.when(
            success: (event) {
              scheduleItems.value = event.value;
            },
            failure: (event) => ToastUtil.errorToast(event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [schedulesState]);

    return BaseScaffold(
      appBar: TopBarTitle(
        content: getAppLocalizations(context).main_navigation_menu_schedules,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            scheduleItems.value == null
                ? schedulesState is Success<List<ResponseScheduleModel>>
                    ? _ScheduleContentList(items: schedulesState.value)
                    : const SizedBox()
                : _ScheduleContentList(items: scheduleItems.value!),
            if (schedulesState is Loading) const LoadingView(),
          ],
        ),
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
    final deviceProvider = ref.read(DeviceListProvider.notifier);
    final scheduleProvider = ref.read(SchedulesProvider.notifier);

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
          deviceProvider.requestGetDevices();
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
                controller: useScrollController(),
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
        : Expanded(
            child: BlankMessage(
              type: BlankMessageType.NEW_SCHEDULE,
              onPressed: () => goToCreateSchedule(),
            ),
          );
  }
}
