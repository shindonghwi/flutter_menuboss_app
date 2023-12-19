import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';

import '../../utils/Common.dart';
import '../../utils/dto/Pair.dart';
import '../utils/Clickable.dart';

class TopBarIconTitleIcon extends HookWidget implements PreferredSizeWidget {
  final String content;
  final bool leadingIsShow;
  final Pair<String, VoidCallback>? leading;
  final List<Pair<String, VoidCallback>> suffixIcons;
  final VoidCallback onBack;

  const TopBarIconTitleIcon({
    super.key,
    this.leading,
    required this.leadingIsShow,
    required this.suffixIcons,
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
                          onPressed: () => onBack.call(),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: LoadSvg(
                              path: "assets/imgs/icon_back.svg",
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
                          child: LoadSvg(
                            path: e.value.first,
                            width: 24,
                            height: 24,
                          ),
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
