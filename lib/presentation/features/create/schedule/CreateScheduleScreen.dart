import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/schedule/ResponseScheduleModel.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss/presentation/components/appbar/TopBarNoneTitleIcon.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/components/loading/LoadingView.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/features/create/schedule/provider/ScheduleRegisterProvider.dart';
import 'package:menuboss/presentation/features/create/schedule/provider/ScheduleSaveInfoProvider.dart';
import 'package:menuboss/presentation/features/create/schedule/provider/ScheduleUpdateProvider.dart';
import 'package:menuboss/presentation/features/create/schedule/widget/ScheduleContentItem.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';

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

    final scheduleRegisterState = ref.watch(ScheduleRegisterProvider);
    final scheduleUpdateState = ref.watch(ScheduleUpdateProvider);
    final scheduleRegisterProvider = ref.read(ScheduleRegisterProvider.notifier);
    final scheduleUpdateProvider = ref.read(ScheduleUpdateProvider.notifier);
    final timelineProvider = ref.read(ScheduleTimelineInfoProvider.notifier);
    final saveProvider = ref.read(ScheduleSaveInfoProvider.notifier);

    void initState() {
      timelineProvider.init();
      saveProvider.init();
      scheduleRegisterProvider.init();
      scheduleUpdateProvider.init();
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        initState();
      });
      return null;
    }, []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (isEditMode.value) {
          saveProvider.changeName(item?.name ?? "");

          final newPlaylistItems = item?.playlists?.asMap().entries.map((e) {
                int index = e.key;
                return e.value.toSimpleSchedulesModelMapper(isRequired: index == 0);
              }).toList() ??
              [];

          timelineProvider.replaceItems(newPlaylistItems);
        }
      });
      return null;
    }, [isEditMode.value]);

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
          scheduleUpdateState.when(
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
    final scheduleRegisterProvider = ref.read(ScheduleRegisterProvider.notifier);
    final scheduleUpdateProvider = ref.read(ScheduleUpdateProvider.notifier);
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
            if (timelineProvider.hasAnyOverlappingTimes()) {
              ToastUtil.errorToast(getAppLocalizations(context).message_time_setting_duplicated);
            } else {
              if (isEditMode) {
                scheduleUpdateProvider.updateSchedule(scheduleId ?? -1, saveState);
              } else {
                scheduleRegisterProvider.registerSchedule(saveState);
              }
            }
          },
        ),
      ),
    );
  }
}
