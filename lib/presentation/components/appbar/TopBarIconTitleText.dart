import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class TopBarIconTitleText extends HookWidget implements PreferredSizeWidget {
  final String content;
  final String? leftIconPath;
  final String? rightText;
  final bool? rightTextActivated;
  final VoidCallback? leftIconOnPressed;
  final VoidCallback? rightIconOnPressed;

  const TopBarIconTitleText({
    super.key,
    this.leftIconPath,
    this.rightText,
    this.rightTextActivated,
    this.leftIconOnPressed,
    this.rightIconOnPressed,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getColorScheme(context).white,
      child: SafeArea(
        child: SizedBox(
          width: getMediaQuery(context).size.width,
          height: 68,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 48,
                  height: 48,
                  margin: const EdgeInsets.only(left: 12.0),
                  child: Clickable(
                    onPressed: () {
                      leftIconOnPressed != null ? leftIconOnPressed?.call() : Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(leftIconPath ?? "assets/imgs/icon_back.svg", width: 24, height: 24),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  content,
                  style: getTextTheme(context).s2b.copyWith(
                        color: getColorScheme(context).colorGray900,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (rightText != null && rightTextActivated != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(right: 12.0),
                    child: Clickable(
                      onPressed: () => rightIconOnPressed?.call(),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          rightText ?? "",
                          style: getTextTheme(context).b1sb.copyWith(
                                color: rightTextActivated!
                                    ? getColorScheme(context).colorPrimary500
                                    : getColorScheme(context).colorGray400,
                              ),
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
  Size get preferredSize => const Size.fromHeight(68);
}
