import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/device/ResponseDeviceModel.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetModifySelector.dart';
import 'package:menuboss/presentation/components/commons/MoreButton.dart';
import 'package:menuboss/presentation/components/label/LabelText.dart';
import 'package:menuboss/presentation/components/loader/LoadImage.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/components/popup/CommonPopup.dart';
import 'package:menuboss/presentation/components/popup/PopupDelete.dart';
import 'package:menuboss/presentation/components/popup/PopupRename.dart';
import 'package:menuboss/presentation/features/main/devices/provider/DeviceListProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class DeviceItem extends HookConsumerWidget {
  final ResponseDeviceModel item;

  const DeviceItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceProvider = ref.read(DeviceListProvider.notifier);

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
                    type: ImagePlaceholderType.Normal,
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
                            content: item.isOnline ? getAppLocalizations(context).common_on : getAppLocalizations(context).common_off,
                            isOn: item.isOnline,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                item.name,
                                style: getTextTheme(context).b2sb.copyWith(
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
                          padding: const EdgeInsets.only(top: 4.0),
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
              ModifyType.Rename,
              ModifyType.Delete,
            ],
            onSelected: (type, text) {
              if (type == ModifyType.Rename) {
                CommonPopup.showPopup(
                  context,
                  child: PopupRename(
                      hint: getAppLocalizations(context).popup_rename_screen_hint,
                      onClicked: (name) {
                        if (name.isNotEmpty) {
                          deviceProvider.requestPatchDeviceName(item.screenId, name);
                          // deviceProvider.renameItem(item, name);
                        }
                      }),
                );
              } else if (type == ModifyType.Delete) {
                CommonPopup.showPopup(
                  context,
                  child: PopupDelete(
                    onClicked: () => deviceProvider.requestDelDevice(item.screenId),
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
