import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/features/media_content/provider/MediaContentsProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

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

    final mediaTabTextColor = currentIndex <= 1 ? getColorScheme(context).colorGray900 : getColorScheme(context).colorGray400;
    final mediaTabDividerColor = currentIndex <= 1 ? getColorScheme(context).colorGray900 : Colors.transparent;
    final canvasTabTextColor = currentIndex > 1 ? getColorScheme(context).colorGray900 : getColorScheme(context).colorGray400;
    final canvasTabDividerColor = currentIndex > 1 ? getColorScheme(context).colorGray900 : Colors.transparent;

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
                  getAppLocalizations(context).media_content_tab_media,
                  style: getTextTheme(context).b2sb.copyWith(
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
                  getAppLocalizations(context).media_content_tab_canvas,
                  style: getTextTheme(context).b2sb.copyWith(
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
