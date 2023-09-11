import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetModifySelector.dart';
import 'package:menuboss/presentation/components/bottom_sheet/CommonBottomSheet.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class MoreButton extends StatelessWidget {
  final List<ModifyType> items;
  final Function(ModifyType, String) onSelected;

  const MoreButton({
    super.key,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onPressed: () {
        CommonBottomSheet.showBottomSheet(
          context,
          child: BottomSheetModifySelector(
            items: items,
            onSelected: (type, text) => onSelected.call(type, text),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SvgPicture.asset(
          "assets/imgs/icon_more.svg",
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            getColorScheme(context).colorGray900,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
