import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss/presentation/components/blank/BlankMessage.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/components/popup/CommonPopup.dart';
import 'package:menuboss/presentation/components/popup/PopupApplyDevice.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/features/apply_screen/widget/ApplyDeviceItem.dart';
import 'package:menuboss/presentation/features/main/devices/provider/DeviceListProvider.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import 'provider/ApplyDeviceCheckListProvider.dart';


class ApplyToDeviceScreen extends HookConsumerWidget {
  const ApplyToDeviceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listKey = GlobalKey<AnimatedListState>();
    final items = ref.watch(deviceListProvider);

    final checkList = ref.watch(applyScreenCheckListProvider);
    final checkListProvider = ref.read(applyScreenCheckListProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        checkListProvider.clear();
      });
      return null;
    },[]);

    return BaseScaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopBarIconTitleNone(
              content: getAppLocalizations(context).apply_screen_title,
            ),
            items.isNotEmpty
                ? Expanded(
              child: Stack(
                children: [
                  AnimatedList(
                    key: listKey,
                    initialItemCount: items.length,
                    padding: const EdgeInsets.only(bottom: 80),
                    itemBuilder: (context, index, animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, -0.15),
                          end: Offset.zero,
                        ).animate(animation),
                        child: FadeTransition(
                          opacity: animation,
                          child: ApplyDeviceItem(
                            isChecked: checkListProvider.isExist(index),
                            onPressed: () {
                              checkListProvider.onChanged(index);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      child: PrimaryFilledButton.largeRound8(
                        content: getAppLocalizations(context).common_done,
                        isActivated: checkList.isNotEmpty,
                        onPressed: () {
                          CommonPopup.showPopup(context, child: PopupApplyDevice(
                            onClicked: (isComplete) {
                              if (isComplete) {
                                Navigator.pop(context);
                              }
                            },
                          ));
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
                : Expanded(
              child: BlankMessage(
                type: BlankMessageType.NEW_PLAYLIST,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
