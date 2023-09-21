import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/components/appbar/TopBarNoneTitleIcon.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/components/loading/LoadingView.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/features/create/schedule/provider/ScheduleRegisterProvider.dart';
import 'package:menuboss/presentation/features/create/schedule/provider/ScheduleSaveInfoProvider.dart';
import 'package:menuboss/presentation/features/create/schedule/widget/ScheduleContentItem.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import 'provider/ScheduleTimelineInfoProvider.dart';
import 'widget/ScheduleInputName.dart';

class CreateScheduleScreen extends HookConsumerWidget {
  const CreateScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleRegisterState = ref.watch(ScheduleRegisterProvider);
    final scheduleRegisterProvider = ref.read(ScheduleRegisterProvider.notifier);
    final timelineProvider = ref.read(ScheduleTimelineInfoProvider.notifier);

    void initState() {
      timelineProvider.init();
      scheduleRegisterProvider.init();
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        initState();
      });
      return null;
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          scheduleRegisterState.when(
            success: (event) {
              initState();
              Navigator.of(context).pop(true);
            },
            failure: (event) => ToastUtil.errorToast(event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [scheduleRegisterState]);

    return BaseScaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: TopBarNoneTitleIcon(
          content: getAppLocalizations(context).create_schedule_title,
        ),
      ),
      body: Container(
        color: getColorScheme(context).white,
        child: SafeArea(
          child: Stack(
            children: [
              const SingleChildScrollView(
                child: Column(
                  children: [
                    ScheduleInputName(
                      initTitle: "",
                    ),
                    ScheduleContentItem()
                  ],
                ),
              ),
              if (scheduleRegisterState is Loading) const LoadingView(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _SaveButton(),
    );
  }
}

class _SaveButton extends HookConsumerWidget {
  const _SaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleRegisterProvider = ref.read(ScheduleRegisterProvider.notifier);
    final saveState = ref.watch(ScheduleSaveInfoProvider);
    final timelineState = ref.watch(ScheduleTimelineInfoProvider);
    final timelineProvider = ref.read(ScheduleTimelineInfoProvider.notifier);

    final isSaveAvailable = timelineState.where((element) => !element.isAddButton).every(
              (element) => element.playlistId! > 0,
            ) &&
        !CollectionUtil.isNullEmptyFromString(saveState.name);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
        child: PrimaryFilledButton.largeRound8(
          content: getAppLocalizations(context).common_save,
          isActivated: isSaveAvailable,
          onPressed: () {
            if (timelineProvider.hasAnyOverlappingTimes()){
              ToastUtil.errorToast(getAppLocalizations(context).message_time_setting_duplicated);
            }else{
              scheduleRegisterProvider.registerSchedule(saveState);
            }
          },
        ),
      ),
    );
  }
}
