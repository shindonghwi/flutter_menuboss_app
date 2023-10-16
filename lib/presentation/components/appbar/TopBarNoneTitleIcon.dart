import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class TopBarNoneTitleIcon extends HookWidget implements PreferredSizeWidget {
  final String content;
  final String? rightIconPath;
  final Color? backgroundColor;
  final bool reverseContentColor;
  final VoidCallback? rightIconOnPressed;

  const TopBarNoneTitleIcon({
    super.key,
    this.rightIconPath,
    this.rightIconOnPressed,
    this.reverseContentColor = false,
    this.backgroundColor,
    required this.content,
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
                  style: getTextTheme(context).s2b.copyWith(
                        color: reverseContentColor ? getColorScheme(context).white : getColorScheme(context).colorGray900,
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
                    onPressed: () {
                      rightIconOnPressed != null ? rightIconOnPressed?.call() : Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(rightIconPath ?? "assets/imgs/icon_close_line.svg",
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                            reverseContentColor ? getColorScheme(context).white : getColorScheme(context).colorGray900,
                            BlendMode.srcIn,
                          )),
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
