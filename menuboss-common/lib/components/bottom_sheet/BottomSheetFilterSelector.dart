import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/Strings.dart';
import 'package:menuboss_common/ui/typography.dart';

import '../../utils/Common.dart';
import '../utils/Clickable.dart';

enum FilterType { NameAsc, NameDesc, NewestFirst, OldestFirst }

class FilterInfo {
  static Map<FilterType, String> getFilterKey(BuildContext context) {
    return {
      FilterType.NameAsc: Strings.of(context).filterKeyNameAsc,
      FilterType.NameDesc: Strings.of(context).filterKeyNameDesc,
      FilterType.NewestFirst: Strings.of(context).filterKeyNewestFirst,
      FilterType.OldestFirst: Strings.of(context).filterKeyOldestFirst
    };
  }

  static Map<FilterType, String> getFilterValue(BuildContext context) {
    return {
      FilterType.NameAsc: Strings.of(context).filterValueNameAsc,
      FilterType.NameDesc: Strings.of(context).filterValueNameDesc,
      FilterType.NewestFirst: Strings.of(context).filterValueNewestFirst,
      FilterType.OldestFirst: Strings.of(context).filterValueOldestFirst
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
