import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/strings.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

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
                      LoadSvg(
                        path: "assets/imgs/icon_new_folder.svg",
                        width: 24,
                        height: 24,
                        color: getColorScheme(context).colorGray900,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          Strings.of(context).commonNewFolder,
                          style: getTextTheme(context).c1m.copyWith(
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
                      LoadSvg(
                        path: "assets/imgs/icon_move_here.svg",
                        width: 24,
                        height: 24,
                        color: getColorScheme(context).colorGray900,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          Strings.of(context).commonMoveHere,
                          style: getTextTheme(context).c1m.copyWith(
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
