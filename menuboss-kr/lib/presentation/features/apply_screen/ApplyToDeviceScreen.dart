import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/device/RequestDeviceApplyContents.dart';
import 'package:menuboss/data/models/device/ResponseDeviceModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/features/apply_screen/provider/PostApplyContentsToScreenProvider.dart';
import 'package:menuboss/presentation/features/main/devices/provider/DeviceListProvider.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss_common/components/button/PrimaryFilledButton.dart';
import 'package:menuboss_common/components/popup/CommonPopup.dart';
import 'package:menuboss_common/components/popup/PopupApplyDevice.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/view_state/EmptyView.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/strings.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/UiState.dart';

import 'provider/ApplyDeviceCheckListProvider.dart';
import 'widget/ApplyDeviceItem.dart';

class ApplyToDeviceScreen extends HookConsumerWidget {
  final RequestDeviceApplyContents? item;

  const ApplyToDeviceScreen({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applyScreenState = ref.watch(postApplyContentsToScreenProvider); // 스크린에 적용 상태
    final applyScreenManager = ref.read(postApplyContentsToScreenProvider.notifier);
    final deviceState = ref.watch(deviceListProvider);
    final deviceManager = ref.read(deviceListProvider.notifier);

    final checkList = ref.watch(applyScreenCheckListProvider);
    final checkListManager = ref.read(applyScreenCheckListProvider.notifier);
    final applyItem = useState<RequestDeviceApplyContents>(item!);

    final deviceList = useState(<ResponseDeviceModel>[]);

    useEffect(() {
      return () {
        Future(() {
          checkListManager.clear();
          applyScreenManager.init();
        });
      };
    }, []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        deviceList.value = [...deviceManager.currentDevices];
      });
      return null;
    }, [deviceState]);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          applyScreenState.when(
            success: (event) async {
              deviceManager.requestGetDevices();
              Toast.showSuccess(context, Strings.of(context).messageApplyScreenSuccess);
              Navigator.of(context).pop();
            },
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [applyScreenState]);

    return BaseScaffold(
      appBar: TopBarIconTitleNone(
        content: Strings.of(context).applyScreenTitle,
        onBack: () => popPageWrapper(context: context),
      ),
      body: SafeArea(
        child: !CollectionUtil.isNullorEmpty(deviceList.value)
            ? Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                deviceManager.requestGetDevices();
              },
              color: getColorScheme(context).colorPrimary500,
              backgroundColor: getColorScheme(context).white,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: deviceList.value.length,
                itemBuilder: (context, index) {
                  return ApplyDeviceItem(
                    item: deviceList.value[index],
                    isChecked: checkListManager.isExist(index),
                    onPressed: () => checkListManager.onChanged(index),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox();
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: getMediaQuery(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                  child: PrimaryFilledButton.largeRound8(
                    content: Strings.of(context).commonConfirm,
                    isActivated: checkList.isNotEmpty,
                    onPressed: () {
                      CommonPopup.showPopup(
                        context,
                        child: PopupApplyDevice(
                          onClicked: (isApply) {
                            if (isApply) {
                              final deviceIds = deviceManager.currentDevices.map((e) => e.screenId).toList();
                              final applyDeviceIds = [
                                for (var i = 0; i < deviceIds.length; i++)
                                  if (checkList.contains(i)) deviceIds[i]
                              ];
                              applyItem.value = applyItem.value.copyWith(screenIds: applyDeviceIds);
                              applyScreenManager.applyToScreen(applyItem.value);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            if (applyScreenState is Loading) const LoadingView()
          ],
        )
            : EmptyView(
          type: BlankMessageType.ADD_SCREEN,
          onPressed: () async {
            try {
              final isAdded = await Navigator.push(
                context,
                nextSlideVerticalScreen(RoutingScreen.ScanQR.route),
              );

              if (isAdded) {
                deviceManager.requestGetDevices();
              }
            } catch (e) {
              debugPrint(e.toString());
            }
          },
        ),
      ),
    );
  }
}
