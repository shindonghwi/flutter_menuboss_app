import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetModifySelector.dart';
import 'package:menuboss/presentation/components/commons/MoreButton.dart';
import 'package:menuboss/presentation/components/label/LabelText.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/components/popup/CommonPopup.dart';
import 'package:menuboss/presentation/components/popup/PopupDelete.dart';
import 'package:menuboss/presentation/components/popup/PopupRename.dart';
import 'package:menuboss/presentation/features/main/devices/model/DeviceListModel.dart';
import 'package:menuboss/presentation/features/main/devices/provider/DeviceListProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class DeviceItem extends HookConsumerWidget {
  final GlobalKey<AnimatedListState> listKey;
  final DeviceListModel item;

  const DeviceItem({
    super.key,
    required this.item,
    required this.listKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceProvider = ref.read(deviceListProvider.notifier);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                const ImagePlaceholder(type: ImagePlaceholderType.Normal),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const LabelText(
                            content: "On",
                            isOn: true,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                item.screenName,
                                style: getTextTheme(context).b2sb.copyWith(
                                      color: getColorScheme(context).colorGray900,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.scheduleName,
                        style: getTextTheme(context).b3m.copyWith(
                              color: getColorScheme(context).colorGray500,
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
                          deviceProvider.renameItem(item, name);
                        }
                      }),
                );
              } else if (type == ModifyType.Delete) {
                CommonPopup.showPopup(
                  context,
                  child: PopupDelete(
                    onClicked: (isCompleted) {
                      if (isCompleted) {
                        deviceProvider.removeItem(item, listKey);
                      }
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
