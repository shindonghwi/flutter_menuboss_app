import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';

import '../../utils/Common.dart';
import '../utils/Clickable.dart';

enum FilterType { NameAsc, NameDesc, NewestFirst, OldestFirst }

class FilterInfo {
  static Map<FilterType, String> getFilterKey(BuildContext context) {
    final isKr = Localizations.localeOf(context).languageCode == "ko";
    return {
      FilterType.NameAsc: "name_asc",
      FilterType.NameDesc: "name_desc",
      FilterType.NewestFirst: "created_desc",
      FilterType.OldestFirst: "created_asc"
    };
  }

  static Map<FilterType, String> getFilterValue(BuildContext context) {
    final isKr = Localizations.localeOf(context).languageCode == "ko";
    return {
      FilterType.NameAsc: isKr ? "이름 (오름차순)" : "Name (A->Z)",
      FilterType.NameDesc: isKr ? "이름 (내림차순)" : "Name (Z->A)",
      FilterType.NewestFirst: isKr ? "최신 순" : "Newest First",
      FilterType.OldestFirst: isKr ? "오래된 순" : "Oldest First"
    };
  }
}

class BottomSheetFilterSelector extends HookWidget {
  final FilterType checkedFilterType;
  final Function(FilterType, String) onSelected;

  const BottomSheetFilterSelector({
    Key? key,
    required this.checkedFilterType,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const filterTypeList = FilterType.values;

    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: FilterInfo.getFilterValue(context).entries.map((e) {
          int index = filterTypeList.indexOf(e.key);
          String value = e.value;
          return Clickable(
            onPressed: () {
              Navigator.pop(context);
              onSelected(filterTypeList[index], value);
            },
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value,
                    style: getTextTheme(context).b2m.copyWith(
                          color: getColorScheme(context).colorGray900,
                        ),
                  ),
                  if (checkedFilterType == filterTypeList[index])
                    LoadSvg(
                      path: "assets/imgs/icon_check_line.svg",
                      width: 24,
                      height: 24,
                      color: getColorScheme(context).colorGray900,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
