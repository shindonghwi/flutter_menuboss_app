import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/ui/Strings.dart';

import '../../ui/colors.dart';
import '../../ui/typography.dart';
import '../../utils/Common.dart';
import '../button/NeutralLineButton.dart';
import '../button/PrimaryFilledButton.dart';

class PopupLogout extends HookWidget {
  final Function(bool isCompleted)? onClicked;

  const PopupLogout({
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
            color: getColorScheme(context).colorPrimary500,
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            Strings.of(context).commonLogout,
            style: getTextTheme(context).b2sb.copyWith(
                  color: getColorScheme(context).colorGray900,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            Strings.of(context).popupLogoutDescription,
            style: getTextTheme(context).b3r.copyWith(
                  color: getColorScheme(context).colorGray500,
                  overflow: TextOverflow.visible,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 32,
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
                child: PrimaryFilledButton.mediumRound8(
                  content: Strings.of(context).commonLogout,
                  isActivated: true,
                  onPressed: () {
                    Navigator.pop(context);
                    onClicked?.call(true);
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