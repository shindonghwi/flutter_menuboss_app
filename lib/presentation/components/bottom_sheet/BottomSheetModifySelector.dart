import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/components/utils/ClickableScale.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../../../navigation/PageMoveUtil.dart';

enum ModifyType { Rename, Delete, ChangeDuration }

final Map<ModifyType, String> modifyDescriptions = {
  ModifyType.Rename: "Rename",
  ModifyType.Delete: "Delete",
  ModifyType.ChangeDuration: "Change duration",
};

class BottomSheetModifySelector extends HookWidget {
  final List<ModifyType> items;
  final Function(ModifyType, String) onSelected;

  const BottomSheetModifySelector({
    Key? key,
    required this.items,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getModifyNameFromType(ModifyType type) {
      return modifyDescriptions[type] ?? "";
    }

    String? getIconPath(ModifyType type) {
      switch (type) {
        case ModifyType.Rename:
          return "assets/imgs/icon_rename.svg";
        case ModifyType.Delete:
          return "assets/imgs/icon_trash.svg";
        case ModifyType.ChangeDuration:
          return "assets/imgs/icon_time_edit.svg";
        default:
          return null;
      }
    }

    Color? getIconColor(ModifyType type) {
      switch (type) {
        case ModifyType.Rename:
          return getColorScheme(context).black;
        case ModifyType.Delete:
          return getColorScheme(context).colorRed500;
        case ModifyType.ChangeDuration:
          return getColorScheme(context).black;
        default:
          return null;
      }
    }

    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: items.map((type) {
            String value = getModifyNameFromType(type);
            String? iconPath = getIconPath(type);
            Color? color = getIconColor(type);
            return ClickableScale(
              onPressed: () {
                onSelected(type, value);
                popPage(context, () {
                  Navigator.pop(context);
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (iconPath != null && color != null)
                      SvgPicture.asset(
                        iconPath,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          color,
                          BlendMode.srcIn,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        value,
                        style: getTextTheme(context).b2sb.copyWith(
                              color: color,
                            ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}
