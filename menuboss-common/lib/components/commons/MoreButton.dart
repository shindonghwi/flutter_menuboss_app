import 'package:flutter/material.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/ui/colors.dart';

import '../../utils/Common.dart';
import '../bottom_sheet/BottomSheetModifySelector.dart';
import '../bottom_sheet/CommonBottomSheet.dart';
import '../utils/Clickable.dart';

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
        child: LoadSvg(
          path: "assets/imgs/icon_more.svg",
          width: 24,
          height: 24,
          color: getColorScheme(context).colorGray600,
        ),
      ),
    );
  }
}
