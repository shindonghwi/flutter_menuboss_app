import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class TopBarTitleButton extends HookWidget implements PreferredSizeWidget {
  final String content;
  final String buttonContent;
  final String iconPath;
  final VoidCallback onPressed;

  const TopBarTitleButton({
    super.key,
    required this.content,
    required this.buttonContent,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: getMediaQuery(context).size.width,
        height: 67,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 24.0),
                child: Text(
                  content,
                  style: getTextTheme(context).s2sb.copyWith(
                        color: Colors.black,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(right: 24.0),
                child: PrimaryFilledButton.smallRound(
                  content: buttonContent,
                  isActivated: true,
                  leftIcon: Container(
                    margin: const EdgeInsets.only(right: 4.0),
                    child: SvgPicture.asset(
                      iconPath,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        getColorScheme(context).white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  onPressed: () => onPressed.call(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(67);
}
