import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';

import '../../utils/Common.dart';
import '../utils/Clickable.dart';

class TopBarNoneTitleIcon extends HookWidget implements PreferredSizeWidget {
  final String content;
  final String? rightIconPath;
  final Color? backgroundColor;
  final bool reverseContentColor;
  final VoidCallback? rightIconOnPressed;
  final VoidCallback onBack;

  const TopBarNoneTitleIcon({
    super.key,
    this.rightIconPath,
    this.rightIconOnPressed,
    this.reverseContentColor = false,
    this.backgroundColor,
    required this.content,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? getColorScheme(context).white,
      child: SafeArea(
        child: SizedBox(
          width: getMediaQuery(context).size.width,
          height: 56,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  content,
                  style: getTextTheme(context).s3sb.copyWith(
                        color:
                            reverseContentColor ? getColorScheme(context).white : getColorScheme(context).colorGray900,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 48,
                  height: 48,
                  margin: const EdgeInsets.only(right: 12.0),
                  child: Clickable(
                    onPressed: () => onBack.call(),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: LoadSvg(
                        path: rightIconPath ?? "assets/imgs/icon_close_line.svg",
                        width: 24,
                        height: 24,
                        color:
                            reverseContentColor ? getColorScheme(context).white : getColorScheme(context).colorGray900,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
