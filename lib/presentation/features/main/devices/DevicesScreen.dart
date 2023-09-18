import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/device/ResponseDeviceModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarTitle.dart';
import 'package:menuboss/presentation/components/blank/BlankMessage.dart';
import 'package:menuboss/presentation/components/button/FloatingButton.dart';
import 'package:menuboss/presentation/components/loading/LoadingView.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/features/main/devices/provider/DeviceListProvider.dart';
import 'package:menuboss/presentation/features/main/devices/widget/DeviceItem.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class DevicesScreen extends HookConsumerWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceState = ref.watch(DeviceListProvider);
    final deviceProvider = ref.read(DeviceListProvider.notifier);

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
            failure: (event) => ToastUtil.errorToast(event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [deviceState]);

    return SafeArea(
      child: Stack(
        children: [
          if (deviceState is Success<List<ResponseDeviceModel>>)
            Column(
              children: [
                TopBarTitle(content: getAppLocalizations(context).main_navigation_menu_screens),
                _DeviceContentList(items: deviceState.value)
              ],
            ),
          if (deviceState is Loading) const LoadingView(),
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
    final listKey = GlobalKey<AnimatedListState>();
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
        ? Expanded(
            child: Stack(
              children: [
                AnimatedList(
                  key: listKey,
                  initialItemCount: items.length,
                  padding: const EdgeInsets.only(bottom: 80),
                  itemBuilder: (context, index, animation) {
                    final item = items[index];
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -0.15),
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(
                        opacity: animation,
                        child: DeviceItem(item: item, listKey: listKey),
                      ),
                    );
                  },
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  margin: const EdgeInsets.only(bottom: 32, right: 24),
                  child: FloatingPlusButton(
                    onPressed: () {
                      goToRegisterDevice();
                    },
                  ),
                ),
              ],
            ),
          )
        : Expanded(
            child: BlankMessage(
              type: BlankMessageType.ADD_SCREEN,
              onPressed: () {
                goToRegisterDevice();
              },
            ),
          );
  }
}
