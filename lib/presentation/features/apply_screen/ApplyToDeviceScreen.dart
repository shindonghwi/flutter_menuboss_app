import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/device/RequestDeviceApplyContents.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/view_state/EmptyView.dart';
import 'package:menuboss/presentation/features/apply_screen/provider/PostApplyContentsToScreenProvider.dart';
import 'package:menuboss/presentation/features/main/devices/provider/DeviceListProvider.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';

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
    final applyScreenState = ref.watch(PostApplyContentsToScreenProvider);
    final applyScreenProvider = ref.read(PostApplyContentsToScreenProvider.notifier);
    final deviceState = ref.watch(DeviceListProvider);
    final deviceProvider = ref.read(DeviceListProvider.notifier);
    final deviceItems = useState([]);

    final checkList = ref.watch(ApplyScreenCheckListProvider);
    final checkListProvider = ref.read(ApplyScreenCheckListProvider.notifier);
    final applyItem = useState<RequestDeviceApplyContents>(item!);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        checkListProvider.clear();
      });
      return null;
    }, []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        deviceItems.value = deviceProvider.currentDevices;
      });
      return null;
    }, [deviceState]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final deviceIds = deviceProvider.currentDevices.map((e) => e.screenId).toList();
        applyItem.value = applyItem.value.copyWith(screenIds: deviceIds);
      });
      return null;
    }, [checkList]);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          applyScreenState.when(
            success: (event) async {
              ToastUtil.successToast("스크린에 적용완료");
              deviceProvider.requestGetDevices();
              applyScreenProvider.init();
              Navigator.of(context).pop();
            },
            failure: (event) => ToastUtil.errorToast(event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [applyScreenState]);

    return BaseScaffold(
      appBar: TopBarIconTitleNone(content: getAppLocalizations(context).apply_screen_title),
      body: SafeArea(
        child: !CollectionUtil.isNullorEmpty(deviceItems.value)
            ? Stack(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: deviceItems.value.length,
                    itemBuilder: (context, index) {
                      return ApplyDeviceItem(
                        item: deviceItems.value[index],
                        isChecked: checkListProvider.isExist(index),
                        onPressed: () {
                          checkListProvider.onChanged(index);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox();
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: getMediaQuery(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                        child: PrimaryFilledButton.largeRound8(
                          content: getAppLocalizations(context).common_done,
                          isActivated: checkList.isNotEmpty,
                          onPressed: () => applyScreenProvider.applyToScreen(applyItem.value),
                        ),
                      ),
                    ),
                  )
                ],
              )
            : EmptyView(
                type: BlankMessageType.ADD_SCREEN,
                onPressed: () async{
                  // void goToRegisterDevice() async {
                    try {
                      final isAdded = await Navigator.push(
                        context,
                        nextSlideVerticalScreen(RoutingScreen.ScanQR.route),
                      );

                      if (isAdded) {
                        deviceProvider.requestGetDevices();
                      }
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  }
                // },
              ),
      ),
    );
  }
}
