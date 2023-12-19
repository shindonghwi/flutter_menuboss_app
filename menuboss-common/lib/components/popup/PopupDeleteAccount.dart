import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/ui/Strings.dart';

import '../../ui/colors.dart';
import '../../ui/typography.dart';
import '../../utils/Common.dart';
import '../button/PrimaryFilledButton.dart';

class PopupDeleteAccount extends HookWidget {
  final Function(bool isCompleted)? onClicked;

  const PopupDeleteAccount({
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
            path: "assets/imgs/icon_check_filled.svg",
            width: 32,
            height: 32,
            color: getColorScheme(context).colorPrimary500,
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            Strings.of(context).popupDeleteAccountTitle,
            style: getTextTheme(context).b2sb.copyWith(
                  color: getColorScheme(context).colorGray900,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            Strings.of(context).popupDeleteAccountDescription,
            style: getTextTheme(context).b3r.copyWith(
                  color: getColorScheme(context).colorGray500,
                  overflow: TextOverflow.visible,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            width: double.infinity,
            child: PrimaryFilledButton.mediumRound8(
              content: Strings.of(context).commonOk,
              isActivated: true,
              onPressed: () {
                Navigator.pop(context);
                onClicked?.call(true);
              },
            ),
          )
        ],
      ),
    );
  }
}
