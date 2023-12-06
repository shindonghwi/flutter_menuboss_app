import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/button/ErrorFilledButton.dart';
import 'package:menuboss/presentation/components/button/NeutralLineButton.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/components/textfield/OutlineTextField.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../../../navigation/PageMoveUtil.dart';

class PopupApplyDevice extends HookWidget {
  final Function(bool isCompleted)? onClicked;

  const PopupApplyDevice({
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
            "assets/imgs/icon_warning.svg",
            width: 36,
            height: 36,
            colorFilter: ColorFilter.mode(
              getColorScheme(context).colorPrimary500,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            getAppLocalizations(context).popup_apply_screen_title,
            style: getTextTheme(context).b2sb.copyWith(
                  color: getColorScheme(context).colorGray900,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            getAppLocalizations(context).popup_apply_screen_description,
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
                  content: getAppLocalizations(context).common_cancel,
                  isActivated: true,
                  onPressed: () {
                    popPage(context, () {
                      Navigator.pop(context);
                    });
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
                  content: getAppLocalizations(context).common_ok,
                  isActivated: true,
                  onPressed: () {
                    popPage(context, () {
                      Navigator.pop(context);
                    });
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
