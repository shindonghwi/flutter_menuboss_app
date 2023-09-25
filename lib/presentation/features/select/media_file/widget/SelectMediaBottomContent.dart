import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/features/select/media_file/provider/SelectMediaCheckListProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';


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
    final checkListState = ref.watch(SelectMediaCheckListProvider);

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
                  onPressed: () => onMovedClick.call(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/imgs/icon_move.svg",
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          checkListState.isNotEmpty
                              ? getColorScheme(context).colorGray900
                              : getColorScheme(context).colorGray400,
                          BlendMode.srcIn,
                        ),
                      ),
                      Text(
                        getAppLocalizations(context).common_move,
                        style: getTextTheme(context).c1sb.copyWith(
                              color: checkListState.isNotEmpty
                                  ? getColorScheme(context).colorGray900
                                  : getColorScheme(context).colorGray400,
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
                  onPressed: () => onDeleteClick.call(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/imgs/icon_trash.svg",
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          checkListState.isNotEmpty
                              ? getColorScheme(context).colorGray900
                              : getColorScheme(context).colorGray400,
                          BlendMode.srcIn,
                        ),
                      ),
                      Text(
                        getAppLocalizations(context).common_delete,
                        style: getTextTheme(context).c1sb.copyWith(
                              color: checkListState.isNotEmpty
                                  ? getColorScheme(context).colorGray900
                                  : getColorScheme(context).colorGray400,
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
