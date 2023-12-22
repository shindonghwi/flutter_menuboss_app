import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/dto/Triple.dart';

class BottomNavBar extends HookConsumerWidget {
  final int currentIndex;
  final List<Triple> iconList;
  final bool isTutorialMode;
  final Function(int)? onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.iconList,
    this.isTutorialMode = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: isTutorialMode ? getColorScheme(context).black.withOpacity(0.7) : getColorScheme(context).white,
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              color: getColorScheme(context).white,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: getColorScheme(context).colorGray100,
                      width: 1,
                    ),
                  ),
                ),
                height: 72,
                child: Container(
                  height: 72,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: getColorScheme(context).colorGray100,
                        width: 1,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                      children: iconList.asMap().entries.map((e) {
                    final index = e.key;
                    final item = e.value;
                    return Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Clickable(
                        onPressed: isTutorialMode ? null : () => onTap?.call(index),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoadSvg(
                              path: currentIndex == index ? item.second : item.first,
                              width: 24,
                              height: 24,
                              color: currentIndex == index && isTutorialMode == false
                                  ? getColorScheme(context).colorPrimary500
                                  : getColorScheme(context).colorGray400,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              item.third,
                              style: getTextTheme(context).c1m.copyWith(
                                    color: currentIndex == index && isTutorialMode == false
                                        ? getColorScheme(context).colorPrimary500
                                        : getColorScheme(context).colorGray400,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList()),
                ),
              ),
            ),
            if (isTutorialMode)
              Container(
                height: 72,
                color: getColorScheme(context).black.withOpacity(0.7),
              )
          ],
        ),
      ),
    );
  }
}
