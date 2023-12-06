import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../../../navigation/PageMoveUtil.dart';

enum FilterType { NameAsc, NameDesc, NewestFirst, OldestFirst }

class FilterInfo {

  static Map<FilterType, String> getFilterKey(BuildContext context) {
    return {
      FilterType.NameAsc: getAppLocalizations(context).filter_key_name_asc,
      FilterType.NameDesc: getAppLocalizations(context).filter_key_name_desc,
      FilterType.NewestFirst: getAppLocalizations(context).filter_key_newest_first,
      FilterType.OldestFirst: getAppLocalizations(context).filter_key_oldest_first
    };
  }

  static Map<FilterType, String> getFilterValue(BuildContext context) {
    return {
      FilterType.NameAsc: getAppLocalizations(context).filter_value_name_asc,
      FilterType.NameDesc: getAppLocalizations(context).filter_value_name_desc,
      FilterType.NewestFirst: getAppLocalizations(context).filter_value_newest_first,
      FilterType.OldestFirst: getAppLocalizations(context).filter_value_oldest_first
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
                popPage(context, () {
                  Navigator.pop(context);
                });
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
                      SvgPicture.asset(
                        "assets/imgs/icon_check_line.svg",
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          getColorScheme(context).colorGray900,
                          BlendMode.srcIn,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}
