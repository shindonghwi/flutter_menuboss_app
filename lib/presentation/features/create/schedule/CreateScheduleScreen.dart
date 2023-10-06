import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/schedule/ResponseSchedulesModel.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss/presentation/components/appbar/TopBarNoneTitleIcon.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/features/create/schedule/provider/ScheduleRegisterProvider.dart';
import 'package:menuboss/presentation/features/create/schedule/provider/ScheduleSaveInfoProvider.dart';
import 'package:menuboss/presentation/features/create/schedule/provider/ScheduleUpdateProvider.dart';
import 'package:menuboss/presentation/features/create/schedule/widget/ScheduleContentItem.dart';
import 'package:menuboss/presentation/features/main/schedules/provider/SchedulesProvider.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../../../../data/models/schedule/ResponseScheduleModel.dart';
import '../../../components/view_state/LoadingView.dart';
import 'provider/ScheduleTimelineInfoProvider.dart';
import 'widget/ScheduleInputName.dart';

class CreateScheduleScreen extends HookConsumerWidget {
  final ResponseScheduleModel? item;

  const CreateScheduleScreen({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = useState(item != null);

    final schedulesManager = ref.read(schedulesProvider.notifier);

    final scheduleUpdateState = ref.watch(scheduleUpdateProvider);
    final scheduleUpdateManager = ref.read(scheduleUpdateProvider.notifier);

    final scheduleRegisterState = ref.watch(scheduleRegisterProvider);
    final scheduleRegisterManager = ref.read(scheduleRegisterProvider.notifier);

    final timelineManager = ref.read(scheduleTimelineInfoProvider.notifier);
    final saveManager = ref.read(ScheduleSaveInfoProvider.notifier);

    useEffect(() {
      return () {
        Future(() {
          timelineManager.init();
          saveManager.init();
          scheduleRegisterManager.init();
          scheduleUpdateManager.init();
        });
      };
    }, []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (isEditMode.value) {
          saveManager.changeName(item?.name ?? "");

          final newPlaylistItems = item?.playlists?.asMap().entries.map((e) {
                int index = e.key;
                return e.value.toSimpleSchedulesModelMapper(isRequired: index == 0);
              }).toList() ??
              [];

          timelineManager.replaceItems(newPlaylistItems);
        }
      });
      return null;
    }, [isEditMode.value]);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          scheduleRegisterState.when(
            success: (event) {
              Toast.showSuccess(context, getAppLocalizations(context).message_register_schedule_success);
              schedulesManager.requestGetSchedules();
              Navigator.of(context).pop();
            },
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
          scheduleUpdateState.when(
            success: (event) {
              Toast.showSuccess(context, getAppLocalizations(context).message_update_schedule_success);
              schedulesManager.requestGetSchedules();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [scheduleRegisterState, scheduleUpdateState]);

    return BaseScaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: isEditMode.value
            ? TopBarIconTitleNone(content: getAppLocalizations(context).edit_schedule_title)
            : TopBarNoneTitleIcon(content: getAppLocalizations(context).create_schedule_title),
      ),
      body: Container(
        color: getColorScheme(context).white,
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    ScheduleInputName(initTitle: item?.name ?? ""),
                    ScheduleContentItem(playlists: item?.playlists),
                  ],
                ),
              ),
              if (scheduleRegisterState is Loading) const LoadingView(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _SaveButton(
        scheduleId: item?.scheduleId,
        isEditMode: isEditMode.value,
      ),
    );
  }
}

class _SaveButton extends HookConsumerWidget {
  final int? scheduleId;
  final bool isEditMode;

  const _SaveButton({
    super.key,
    required this.scheduleId,
    required this.isEditMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleUpdateManager = ref.read(scheduleUpdateProvider.notifier);
    final scheduleRegisterManager = ref.read(scheduleRegisterProvider.notifier);
    final saveState = ref.watch(ScheduleSaveInfoProvider);
    final timelineState = ref.watch(scheduleTimelineInfoProvider);
    final timelineManager = ref.read(scheduleTimelineInfoProvider.notifier);

    final isSaveAvailable = timelineState
            .where((element) => !element.isAddButton)
            .every((element) => element.playlistId! > 0 && !element.timeIsDuplicate) &&
        !CollectionUtil.isNullEmptyFromString(saveState.name);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
        child: PrimaryFilledButton.largeRound8(
          content: getAppLocalizations(context).common_save,
          isActivated: isSaveAvailable,
          onPressed: () {
            if (timelineManager.hasAnyOverlappingTimes()) {
              Toast.showError(context, getAppLocalizations(context).message_time_setting_duplicated);
            } else {
              if (isEditMode) {
                scheduleUpdateManager.updateSchedule(scheduleId ?? -1, saveState);
              } else {
                scheduleRegisterManager.registerSchedule(saveState);
              }
            }
          },
        ),
      ),
    );
  }
}
