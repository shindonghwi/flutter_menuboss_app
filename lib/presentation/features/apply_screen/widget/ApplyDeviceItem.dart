import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/data/models/device/ResponseDeviceModel.dart';
import 'package:menuboss/presentation/components/checkbox/checkbox/BasicBorderCheckBox.dart';
import 'package:menuboss/presentation/components/label/LabelText.dart';
import 'package:menuboss/presentation/components/loader/LoadImage.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/components/utils/ClickableScale.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';

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
                        content: item.isOnline
                            ? getAppLocalizations(context).common_on
                            : getAppLocalizations(context).common_off,
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
                        style: getTextTheme(context).b3r.copyWith(
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
