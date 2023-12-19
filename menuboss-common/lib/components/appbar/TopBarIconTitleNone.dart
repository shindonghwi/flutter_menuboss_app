import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';

import '../../utils/Common.dart';
import '../utils/Clickable.dart';

class TopBarIconTitleNone extends HookWidget implements PreferredSizeWidget {
  final String content;
  final String? leftIconPath;
  final VoidCallback? leftIconOnPressed;
  final VoidCallback onBack;

  const TopBarIconTitleNone({
    super.key,
    this.leftIconPath,
    this.leftIconOnPressed,
    required this.content,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getColorScheme(context).white,
      child: SafeArea(
        child: SizedBox(
          width: getMediaQuery(context).size.width,
          height: 56,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 48,
                  height: 48,
                  margin: const EdgeInsets.only(left: 12.0),
                  child: Clickable(
                    onPressed: () => onBack.call(),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: LoadSvg(
                        path: leftIconPath ?? "assets/imgs/icon_back.svg",
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  content,
                  style: getTextTheme(context).s3sb.copyWith(
                        color: getColorScheme(context).colorGray900,
                      ),
                  textAlign: TextAlign.center,
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
