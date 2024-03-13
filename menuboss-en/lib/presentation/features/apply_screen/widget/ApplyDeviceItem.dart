import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/data/models/device/ResponseDeviceModel.dart';
import 'package:menuboss_common/components/checkbox/checkbox/BasicBorderCheckBox.dart';
import 'package:menuboss_common/components/label/LabelText.dart';
import 'package:menuboss_common/components/loader/LoadImage.dart';
import 'package:menuboss_common/components/placeholder/PlaceholderType.dart';
import 'package:menuboss_common/components/utils/ClickableScale.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/Common.dart';

class ApplyDeviceItem extends HookWidget {
  final ResponseDeviceModel item;
  final bool isChecked;
  final VoidCallback onPressed;

  const ApplyDeviceItem({
    super.key,
    required this.onPressed,
    required this.isChecked,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return ClickableScale(
      onPressed: () => onPressed.call(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: LoadImage(
                key: ValueKey(item.screenId),
                url: item.content?.imageUrl,
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
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          item.name,
                          style: getTextTheme(context).b2m.copyWith(
                                color: getColorScheme(context).colorGray900,
                              ),
                        ),
                      ),
                    ],
                  ),
                  if (!CollectionUtil.isNullEmptyFromString(item.content?.name))
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
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
            IgnorePointer(
              child: BasicBorderCheckBox(
                isChecked: isChecked,
                onChange: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
