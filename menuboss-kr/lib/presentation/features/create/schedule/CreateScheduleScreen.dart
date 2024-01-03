import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/features/create/schedule/provider/ScheduleRegisterProvider.dart';
import 'package:menuboss/presentation/features/create/schedule/provider/ScheduleSaveInfoProvider.dart';
import 'package:menuboss/presentation/features/create/schedule/provider/ScheduleUpdateProvider.dart';
import 'package:menuboss/presentation/features/create/schedule/widget/ScheduleContentItem.dart';
import 'package:menuboss/presentation/features/main/schedules/provider/SchedulesProvider.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss_common/components/appbar/TopBarNoneTitleIcon.dart';
import 'package:menuboss_common/components/button/PrimaryFilledButton.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/Strings.dart';
import 'package:menuboss_common/ui/tutorial/model/TutorialKey.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/UiState.dart';

import '../../../../data/models/schedule/ResponseScheduleModel.dart';
import '../../../../navigation/PageMoveUtil.dart';
import '../../main/widget/TutorialView.dart';
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

    final tutorialOpacity = useState(0.0);

    final initialItems = [
      timelineManager.createScheduleItem(
          -1, true, false, Strings.of(context).createScheduleDefaultPlaylistTitleBasic, null, null),
      timelineManager.createScheduleItem(-2, false, false,
          Strings.of(context).createScheduleDefaultPlaylistTitleMorning, "06:00", "11:00"),
      timelineManager.createScheduleItem(-3, false, false,
          Strings.of(context).createScheduleDefaultPlaylistTitleLunch, "11:00", "15:00"),
      timelineManager.createScheduleItem(-4, false, false,
          Strings.of(context).createScheduleDefaultPlaylistTitleDinner, "15:00", "23:59"),
      timelineManager.createScheduleItem(-5, false, true, "", null, null),
    ];

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
        } else {
          tutorialOpacity.value = 1.0;
          timelineManager.setInitialItems(initialItems);
        }
      });
      return null;
    }, [isEditMode.value]);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          scheduleRegisterState.when(
            success: (event) {
              Toast.showSuccess(context, Strings.of(context).messageRegisterScheduleSuccess);
              schedulesManager.requestGetSchedules();
              Navigator.of(context).pop();
            },
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
          scheduleUpdateState.when(
            success: (event) {
              Toast.showSuccess(context, Strings.of(context).messageUpdateScheduleSuccess);
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

    return Stack(
      children: [
        BaseScaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56.0),
            child: isEditMode.value
                ? TopBarIconTitleNone(
              content: Strings.of(context).editScheduleTitle,
              onBack: () => popPageWrapper(context: context),
            )
                : TopBarNoneTitleIcon(
              content: Strings.of(context).createScheduleTitle,
              onBack: () => popPageWrapper(context: context),
            ),
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
        ),

        // 튜토리얼 화면
        AnimatedOpacity(
          opacity: tutorialOpacity.value,
          duration: const Duration(milliseconds: 300),
          child: IgnorePointer(
            ignoring: tutorialOpacity.value == 0,
            child: TutorialView(
              tutorialKey: TutorialKey.ScheduleMakeKey,
              onTutorialClosed: () => tutorialOpacity.value = 0.0,
            ),
          ),
        ),
      ],
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
        .every((element) => element.playlistId! > 0 && !element.timeIsDuplicate);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
        child: PrimaryFilledButton.largeRound8(
          content: Strings.of(context).commonSave,
          isActivated: isSaveAvailable,
          onPressed: () {
            if (timelineManager.hasAnyOverlappingTimes()) {
              Toast.showError(context, Strings.of(context).messageTimeSettingDuplicated);
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
