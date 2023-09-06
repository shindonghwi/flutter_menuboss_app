import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetFilterSelector.dart';
import 'package:menuboss/presentation/components/bottom_sheet/CommonBottomSheet.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class FilterButton extends HookWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {

    final filterText = useState(filterDescriptions[FilterType.NameAsc]);

    return Container(
      constraints: const BoxConstraints(
        minWidth: 112,
      ),
      decoration: BoxDecoration(
        color: getColorScheme(context).colorGray100,
        borderRadius: const BorderRadius.all(Radius.circular(100)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => CommonBottomSheet.showBottomSheet(
            context,
            child: BottomSheetFilterSelector(
              onSelected: (FilterType type, String text) {
                filterText.value = text;
              },
            ),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
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
                    getColorScheme(context).colorGray400,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
