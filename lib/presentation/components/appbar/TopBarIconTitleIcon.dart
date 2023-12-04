import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

class TopBarIconTitleIcon extends HookWidget implements PreferredSizeWidget {
  final String content;
  final bool leadingIsShow;
  final Pair<String, VoidCallback>? leading;
  final List<Pair<String, VoidCallback>> suffixIcons;

  const TopBarIconTitleIcon({
    super.key,
    this.leading,
    required this.leadingIsShow,
    required this.suffixIcons,
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (leadingIsShow)
                      Container(
                        width: 48,
                        height: 48,
                        margin: const EdgeInsets.only(left: 12),
                        child: Clickable(
                          onPressed: () {
                            popPage(context, () {
                              leading != null ? leading?.second.call() : Navigator.pop(context);
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              leading?.first ?? "assets/imgs/icon_back.svg",
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: getMediaQuery(context).size.width * 0.5,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: leadingIsShow ? 12 : 24),
                        child: Text(
                          content,
                          style: getTextTheme(context).s3sb.copyWith(
                                color: getColorScheme(context).colorGray900,
                              ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: suffixIcons.asMap().entries.map((e) {
                    int index = e.key;
                    return Container(
                      margin: EdgeInsets.only(right: index == suffixIcons.length - 1 ? 16.0 : 0.0),
                      child: Clickable(
                        onPressed: () => e.value.second.call(),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(e.value.first, width: 24, height: 24),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
