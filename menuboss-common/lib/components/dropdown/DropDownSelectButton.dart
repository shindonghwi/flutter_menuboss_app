import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

class DropDownSelectButton extends HookWidget {
  final List<String> items;
  final String? initialValue;
  final int height;
  final void Function(bool) onOpened;
  final void Function(int, String) onSelected; // index, text

  const DropDownSelectButton.extraSmall({
    Key? key,
    required this.items,
    this.initialValue,
    required this.onOpened,
    required this.onSelected,
  })  : height = 32,
        super(key: key);

  const DropDownSelectButton.small({
    Key? key,
    required this.items,
    this.initialValue,
    required this.onOpened,
    required this.onSelected,
  })  : height = 44,
        super(key: key);

  const DropDownSelectButton.medium({
    Key? key,
    required this.items,
    this.initialValue,
    required this.onOpened,
    required this.onSelected,
  })  : height = 48,
        super(key: key);

  const DropDownSelectButton.large({
    Key? key,
    required this.items,
    this.initialValue,
    required this.onOpened,
    required this.onSelected,
  })  : height = 52,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentValue = useState(initialValue ?? (items.isNotEmpty ? items[0] : null));
    final isDropdownOpened = useState(false);
    double dropdownMaxHeight = items.length <= 3 ? height.toDouble() * items.length : height * 3.5;

    var textColor = getColorScheme(context).colorGray900;
    var textStyle = getTextTheme(context).c1m.copyWith(color: textColor);

    switch (height) {
      case 32:
        textStyle = getTextTheme(context).c1m.copyWith(color: textColor);
        break;
      case 44:
      case 48:
      case 52:
        textStyle = getTextTheme(context).b3m.copyWith(color: textColor);
        break;
    }

    Widget listItem(int index, String item) {
      bool isSelected = item == currentValue.value;
      return Clickable(
        onPressed: () {
          currentValue.value = item;
          onSelected(index, item);
          isDropdownOpened.value = false;
        },
        child: Container(
          width: double.infinity,
          height: height.toDouble(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.centerLeft,
          color: isSelected ? getColorScheme(context).colorGray50 : Colors.transparent,
          child: Text(
            item,
            style: textStyle,
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Clickable(
          onPressed: () {
            isDropdownOpened.value = !isDropdownOpened.value;
            onOpened(isDropdownOpened.value);
          },
          child: Container(
            height: height.toDouble(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              border: Border.all(color: getColorScheme(context).colorGray300),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    currentValue.value ?? 'Select an item',
                    style: textStyle,
                  ),
                ),
                Transform.rotate(
                  angle: (isDropdownOpened.value ? 0 : 180) * math.pi / 180,
                  child: LoadSvg(
                    path: 'assets/imgs/icon_down.svg',
                    width: 20,
                    height: 20,
                    color: getColorScheme(context).colorGray600,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isDropdownOpened.value)
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            height: dropdownMaxHeight,
            decoration: BoxDecoration(
              border: Border.all(color: getColorScheme(context).colorGray300),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return listItem(index, items[index]);
                },
              ),
            ),
          ),
      ],
    );
  }
}
