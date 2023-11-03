import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class TopBarTitle extends HookWidget implements PreferredSizeWidget {
  final String content;

  const TopBarTitle({
    super.key,
    required this.content,
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
                  margin: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    content,
                    style: getTextTheme(context).s3b.copyWith(
                          color: getColorScheme(context).colorGray900,
                        ),
                    textAlign: TextAlign.center,
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
