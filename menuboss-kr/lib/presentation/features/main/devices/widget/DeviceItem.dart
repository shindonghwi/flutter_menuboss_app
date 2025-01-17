import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/data/models/device/ResponseDeviceModel.dart';
import 'package:menuboss/presentation/features/main/devices/provider/DeviceListProvider.dart';
import 'package:menuboss/presentation/features/main/devices/provider/DeviceShowNameEventProvider.dart';
import 'package:menuboss_common/components/bottom_sheet/BottomSheetModifySelector.dart';
import 'package:menuboss_common/components/commons/MoreButton.dart';
import 'package:menuboss_common/components/label/LabelText.dart';
import 'package:menuboss_common/components/loader/LoadImage.dart';
import 'package:menuboss_common/components/placeholder/PlaceholderType.dart';
import 'package:menuboss_common/components/popup/CommonPopup.dart';
import 'package:menuboss_common/components/popup/PopupDelete.dart';
import 'package:menuboss_common/components/popup/PopupRename.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/Common.dart';

class DeviceItem extends HookConsumerWidget {
  final ResponseDeviceModel item;

  const DeviceItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceManager = ref.read(deviceListProvider.notifier);
    final showNameEventManager = ref.read(deviceShowNameEventProvider.notifier);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: LoadImage(
                    url: item.content?.imageUrl ?? "",
                    type: ImagePlaceholderType.Size_80,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          LabelText(
                            content: item.isOnline
                                ? getString(context).commonOn
                                : getString(context).commonOff,
                            isOn: item.isOnline,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                item.name,
                                style: getTextTheme(context).b2m.copyWith(
                                      color: getColorScheme(context).colorGray900,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (!CollectionUtil.isNullEmptyFromString(item.content?.name))
                        Padding(
                          padding: const EdgeInsets.only(top: 5.5),
                          child: Text(
                            item.content?.name ?? "",
                            style: getTextTheme(context).b3m.copyWith(
                                  color: getColorScheme(context).colorGray500,
                                ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          MoreButton(
            items: const [
              ModifyType.ShowNameToScreen,
              ModifyType.Rename,
              ModifyType.Delete,
            ],
            onSelected: (type, text) {
              if (type == ModifyType.ShowNameToScreen) {
                showNameEventManager.requestSendNameShowEvent(item.screenId);
              }
              if (type == ModifyType.Rename) {
                CommonPopup.showPopup(
                  context,
                  child: PopupRename(
                    title: getString(context).popupRenameTitle,
                    hint: getString(context).popupRenameScreenHint,
                    name: item.name,
                    onClicked: (name) {
                      if (name.isNotEmpty) {
                        deviceManager.requestPatchDeviceName(item.screenId, name);
                      }
                    },
                  ),
                );
              } else if (type == ModifyType.Delete) {
                CommonPopup.showPopup(
                  context,
                  child: PopupDelete(
                    onClicked: () {
                      deviceManager.requestDelDevice(item.screenId);
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
