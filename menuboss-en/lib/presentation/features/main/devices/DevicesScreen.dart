import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/device/ResponseDeviceModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/features/main/devices/provider/DeviceListProvider.dart';
import 'package:menuboss/presentation/features/main/devices/provider/DeviceShowNameEventProvider.dart';
import 'package:menuboss/presentation/features/main/devices/widget/DeviceItem.dart';
import 'package:menuboss_common/components/appbar/TopBarTitle.dart';
import 'package:menuboss_common/components/button/FloatingPlusButton.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/view_state/EmptyView.dart';
import 'package:menuboss_common/components/view_state/FailView.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/Strings.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/UiState.dart';

class DevicesScreen extends HookConsumerWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceState = ref.watch(deviceListProvider);
    final deviceManager = ref.read(deviceListProvider.notifier);

    final deviceShowNameEventState = ref.watch(deviceShowNameEventProvider);
    final deviceShowNameEventManager = ref.read(deviceShowNameEventProvider.notifier);

    useEffect(() {
      return () {
        Future(() {
          deviceManager.init();
          deviceShowNameEventManager.init();
        });
      };
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          deviceState.when(
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        handleUiStateChange();
      });
      return null;
    }, [deviceState]);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          deviceShowNameEventState.when(
            success: (event) {
              Toast.showSuccess(context, Strings.of(context).messageSendEventNameShowSuccess);
            },
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        handleUiStateChange();
      });
      return null;
    }, [deviceShowNameEventState]);

    return SafeArea(
      child: Column(
        children: [
          TopBarTitle(content: Strings.of(context).mainNavigationMenuScreens),
          Expanded(
            child: Stack(
              children: [
                if (deviceState is Failure)
                  FailView(onPressed: () => deviceManager.requestGetDevices())
                else if (deviceState is Success<List<ResponseDeviceModel>>)
                  _DeviceContentList(items: deviceState.value),
                if (deviceState is Loading || deviceShowNameEventState is Loading) const LoadingView(),
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
    final deviceManager = ref.read(deviceListProvider.notifier);

    void goToRegisterDevice() async {
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
    }

    return items.isNotEmpty
        ? Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  deviceManager.requestGetDevices();
                },
                color: getColorScheme(context).colorPrimary500,
                backgroundColor: getColorScheme(context).white,
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(24, 0, 12, 100),
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 0);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return DeviceItem(item: items[index]);
                  },
                  itemCount: items.length,
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(bottom: 16, right: 24),
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
