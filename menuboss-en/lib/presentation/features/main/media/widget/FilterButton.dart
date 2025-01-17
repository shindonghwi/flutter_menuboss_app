import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:menuboss/domain/usecases/local/app/GetMediaFilterTypeUseCase.dart';
import 'package:menuboss_common/components/bottom_sheet/BottomSheetFilterSelector.dart';
import 'package:menuboss_common/components/bottom_sheet/CommonBottomSheet.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

class FilterButton extends HookWidget {
  final Map<FilterType, String> filterValues;
  final Function(FilterType type, String text) onSelected;

  const FilterButton({
    super.key,
    required this.filterValues,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final filterText = useState(filterValues[FilterType.NewestFirst]);

    useEffect(() {
      GetIt.instance<GetMediaFilterTypeUseCase>().call(filterValues).then((response) {
        filterText.value = filterValues[response];
      });
      return null;
    }, []);

    return Clickable(
      onPressed: () {
        CommonBottomSheet.showBottomSheet(
          context,
          child: BottomSheetFilterSelector(
            checkedFilterType: FilterType.values.firstWhere(
              (element) => filterValues[element] == filterText.value,
            ),
            onSelected: (FilterType type, String text) {
              filterText.value = text;
              onSelected(type, text);
            },
          ),
        );
      },
      child: Container(
        height: 40,
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                filterText.value.toString(),
                style: getTextTheme(context).c1sb.copyWith(
                      color: getColorScheme(context).colorGray900,
                    ),
              ),
            ),
            LoadSvg(
              path: "assets/imgs/icon_down.svg",
              width: 16,
              height: 16,
              color: getColorScheme(context).colorGray900,
            ),
          ],
        ),
      ),
    );
  }
}
