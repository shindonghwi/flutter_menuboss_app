import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/components/utils/ClickableScale.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../../../navigation/PageMoveUtil.dart';

enum ModifyType { ShowNameToScreen, Rename, Delete }



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
    Locale currentLocale = Localizations.localeOf(context);

    final Map<ModifyType, String> modifyDescriptions = {
      ModifyType.ShowNameToScreen: getAppLocalizations(context).bottom_sheet_menu_display_show_name,
      ModifyType.Rename: getAppLocalizations(context).common_rename,
      ModifyType.Delete: getAppLocalizations(context).common_delete,
    };

    String getModifyNameFromType(ModifyType type) {
      return modifyDescriptions[type] ?? "";
    }

    String? getIconPath(ModifyType type) {
      switch (type) {
        case ModifyType.ShowNameToScreen:
          return "assets/imgs/icon_display_screen.svg";
        case ModifyType.Rename:
          return "assets/imgs/icon_rename.svg";
        case ModifyType.Delete:
          return "assets/imgs/icon_trash.svg";
        default:
          return null;
      }
    }

    Color? getIconColor(ModifyType type) {
      switch (type) {
        case ModifyType.ShowNameToScreen:
          return getColorScheme(context).black;
        case ModifyType.Rename:
          return getColorScheme(context).black;
        case ModifyType.Delete:
          return getColorScheme(context).colorRed500;
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
                popPage(context, () {
                  Navigator.pop(context);
                });
                onSelected(type, value);
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
                        style: getTextTheme(context).b2m.copyWith(
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
