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

class PopupDelete extends HookWidget {
  final Function(bool isCompleted)? onClicked;

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
          SvgPicture.asset(
            "assets/imgs/icon_warning.svg",
            width: 36,
            height: 36,
            colorFilter: ColorFilter.mode(
              getColorScheme(context).colorRed500,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            getAppLocalizations(context).popup_delete_title,
            style: getTextTheme(context).b2b.copyWith(
                  color: getColorScheme(context).colorGray900,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            getAppLocalizations(context).popup_delete_description,
            style: getTextTheme(context).b3m.copyWith(
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
                  content: getAppLocalizations(context).common_cancel,
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
                  content: getAppLocalizations(context).common_delete,
                  isActivated: true,
                  onPressed: () {
                    onClicked?.call(true);
                    Navigator.pop(context);
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
