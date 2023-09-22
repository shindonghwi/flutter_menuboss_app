import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:menuboss/domain/usecases/local/app/GetMediaFilterTypeUseCase.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetFilterSelector.dart';
import 'package:menuboss/presentation/components/bottom_sheet/CommonBottomSheet.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class FilterButton extends HookWidget {
  final Function(FilterType type, String text) onSelected;

  const FilterButton({
    super.key,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final filterText = useState(filterDescriptions[FilterType.NewestFirst]);

    useEffect(() {
      GetIt.instance<GetMediaFilterTypeUseCase>().call().then((response) {
        filterText.value = filterDescriptions[response];
      });
      return null;
    }, []);

    return Clickable(
      onPressed: () {
        CommonBottomSheet.showBottomSheet(
          context,
          child: BottomSheetFilterSelector(
            checkedFilterType: FilterType.values.firstWhere(
              (element) => filterDescriptions[element] == filterText.value,
            ),
            onSelected: (FilterType type, String text) {
              filterText.value = text;
              onSelected(type, text);
            },
          ),
        );
      },
      child: Padding(
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
            SvgPicture.asset(
              "assets/imgs/icon_down.svg",
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(
                getColorScheme(context).colorGray900,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
