import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/features/select/media_file/provider/SelectMediaCheckListProvider.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/Strings.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

class SelectMediaBottomContent extends HookConsumerWidget {
  final VoidCallback onMovedClick;
  final VoidCallback onDeleteClick;

  const SelectMediaBottomContent({
    super.key,
    required this.onMovedClick,
    required this.onDeleteClick,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkListState = ref.watch(selectMediaCheckListProvider);

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
                  onPressed: () {
                    if (checkListState.isNotEmpty) {
                      onMovedClick.call();
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadSvg(
                        path: "assets/imgs/icon_move.svg",
                        width: 24,
                        height: 24,
                        color: checkListState.isNotEmpty
                            ? getColorScheme(context).colorGray900
                            : getColorScheme(context).colorGray400,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          Strings.of(context).commonMove,
                          style: getTextTheme(context).c1sb.copyWith(
                                color: checkListState.isNotEmpty
                                    ? getColorScheme(context).colorGray900
                                    : getColorScheme(context).colorGray400,
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
                  onPressed: () {
                    if (checkListState.isNotEmpty) {
                      onDeleteClick.call();
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadSvg(
                        path: "assets/imgs/icon_trash.svg",
                        width: 24,
                        height: 24,
                        color: checkListState.isNotEmpty
                            ? getColorScheme(context).colorGray900
                            : getColorScheme(context).colorGray400,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          Strings.of(context).commonDelete,
                          style: getTextTheme(context).c1sb.copyWith(
                                color: checkListState.isNotEmpty
                                    ? getColorScheme(context).colorGray900
                                    : getColorScheme(context).colorGray400,
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
