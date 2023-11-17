import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/button/NeutralLineButton.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../../../navigation/PageMoveUtil.dart';

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
          SvgPicture.asset(
            "assets/imgs/icon_check_filled.svg",
            width: 32,
            height: 32,
            colorFilter: ColorFilter.mode(
              getColorScheme(context).colorPrimary500,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            getAppLocalizations(context).popup_delete_account_title,
            style: getTextTheme(context).b2b.copyWith(
                  color: getColorScheme(context).colorGray900,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            getAppLocalizations(context).popup_delete_account_description,
            style: getTextTheme(context).b3m.copyWith(
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
              content: getAppLocalizations(context).common_ok,
              isActivated: true,
              onPressed: () {
                popPage(context, () {
                  Navigator.pop(context);
                });
                onClicked?.call(true);
              },
            ),
          )
        ],
      ),
    );
  }
}
