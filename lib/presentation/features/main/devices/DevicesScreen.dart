import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/device/ResponseDeviceModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarTitle.dart';
import 'package:menuboss/presentation/components/button/FloatingButton.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/view_state/EmptyView.dart';
import 'package:menuboss/presentation/components/view_state/FailView.dart';
import 'package:menuboss/presentation/features/main/devices/provider/DeviceListProvider.dart';
import 'package:menuboss/presentation/features/main/devices/widget/DeviceItem.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../../../components/view_state/LoadingView.dart';

class DevicesScreen extends HookConsumerWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceState = ref.watch(DeviceListProvider);
    final deviceProvider = ref.read(DeviceListProvider.notifier);
    final deviceList = useState<List<ResponseDeviceModel>?>(null);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        deviceProvider.requestGetDevices();
      });
      return null;
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          deviceState.when(
            success: (event) {
              deviceList.value = event.value;
              deviceProvider.init();
            },
            failure: (event) => ToastUtil.errorToast(event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [deviceState]);

    return SafeArea(
      child: Column(
        children: [
          TopBarTitle(content: getAppLocalizations(context).main_navigation_menu_screens),
          Expanded(
            child: Stack(
              children: [
                if (deviceState is Failure)
                  FailView(onPressed: () => deviceProvider.requestGetDevices())
                else if (deviceList.value != null)
                  _DeviceContentList(items: deviceList.value!)
                else if (deviceState is Success<List<ResponseDeviceModel>>)
                  _DeviceContentList(items: deviceState.value),
                if (deviceState is Loading) const LoadingView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceContentList extends HookConsumerWidget {
  final List<ResponseDeviceModel> items;

  const _DeviceContentList({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceProvider = ref.read(DeviceListProvider.notifier);

    void goToRegisterDevice() async {
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

    return items.isNotEmpty
        ? Stack(
            children: [
              ListView.separated(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 0);
                },
                itemBuilder: (BuildContext context, int index) {
                  return DeviceItem(item: items[index]);
                },
                itemCount: items.length,
              ),
              Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(bottom: 32, right: 24),
                child: FloatingPlusButton(
                  onPressed: () => goToRegisterDevice(),
                ),
              ),
            ],
          )
        : EmptyView(
            type: BlankMessageType.ADD_SCREEN,
            onPressed: () => goToRegisterDevice(),
          );
  }
}
