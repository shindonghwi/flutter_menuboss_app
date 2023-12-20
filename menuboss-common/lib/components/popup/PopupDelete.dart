import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/ui/Strings.dart';

import '../../ui/colors.dart';
import '../../ui/typography.dart';
import '../../utils/Common.dart';
import '../button/ErrorFilledButton.dart';
import '../button/NeutralLineButton.dart';

class PopupDelete extends HookWidget {
  final VoidCallback onClicked;

  const PopupDelete({
    super.key,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LoadSvg(
            path: "assets/imgs/icon_warning.svg",
            width: 32,
            height: 32,
            color: getColorScheme(context).colorRed500,
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            Strings.of(context).popupDeleteTitle,
            style: getTextTheme(context).b2sb.copyWith(
                  color: getColorScheme(context).colorGray900,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            Strings.of(context).popupDeleteDescription,
            style: getTextTheme(context).b3m.copyWith(
                  color: getColorScheme(context).colorGray500,
                  overflow: TextOverflow.visible,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: NeutralLineButton.mediumRound8(
                  content: Strings.of(context).commonCancel,
                  isActivated: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: ErrorFilledButton.mediumRound8(
                  content: Strings.of(context).commonDelete,
                  isActivated: true,
                  onPressed: () {
                    Navigator.pop(context);
                    onClicked.call();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
