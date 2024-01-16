import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

class MediaContentTabView extends HookConsumerWidget {
  final int currentIndex;
  final Function(int index) onTap;

  const MediaContentTabView({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaTabTextColor = currentIndex <= 1
        ? getColorScheme(context).colorGray900
        : getColorScheme(context).colorGray400;
    final mediaTabDividerColor =
        currentIndex <= 1 ? getColorScheme(context).colorGray900 : Colors.transparent;
    final canvasTabTextColor = currentIndex > 1
        ? getColorScheme(context).colorGray900
        : getColorScheme(context).colorGray400;
    final canvasTabDividerColor =
        currentIndex > 1 ? getColorScheme(context).colorGray900 : Colors.transparent;

    return Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Clickable(
            onPressed: () => onTap.call(0),
            child: Container(
              padding: const EdgeInsets.only(top: 24, bottom: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: mediaTabDividerColor,
                    width: 2,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  getString(context).mediaContentTabMedia,
                  style: getTextTheme(context).b2m.copyWith(
                        color: mediaTabTextColor,
                      ),
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Clickable(
            onPressed: () => onTap.call(2),
            child: Container(
              padding: const EdgeInsets.only(top: 24, bottom: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: canvasTabDividerColor,
                    width: 2,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  getString(context).mediaContentTabCanvas,
                  style: getTextTheme(context).b2m.copyWith(
                        color: canvasTabTextColor,
                      ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
