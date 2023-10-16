import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class DestinationFolderBottomContent extends HookConsumerWidget {
  final VoidCallback onNewFolderClick;
  final VoidCallback onMoveHereClick;

  const DestinationFolderBottomContent({
    super.key,
    required this.onNewFolderClick,
    required this.onMoveHereClick,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: getColorScheme(context).colorGray50,
      child: SafeArea(
        child: Container(
          height: 72,
          color: getColorScheme(context).colorGray50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Clickable(
                  onPressed: () => onNewFolderClick.call(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/imgs/icon_new_folder.svg",
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          getColorScheme(context).colorGray900,
                          BlendMode.srcIn,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          getAppLocalizations(context).common_new_folder,
                          style: getTextTheme(context).c1sb.copyWith(
                                color: getColorScheme(context).colorGray900,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Clickable(
                  onPressed: () => onMoveHereClick.call(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/imgs/icon_trash.svg",
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          getColorScheme(context).colorGray900,
                          BlendMode.srcIn,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          getAppLocalizations(context).common_move_here,
                          style: getTextTheme(context).c1sb.copyWith(
                                color: getColorScheme(context).colorGray900,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
