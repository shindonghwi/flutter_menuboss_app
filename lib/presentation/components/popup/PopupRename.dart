import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/components/button/NeutralLineButton.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/components/textfield/OutlineTextField.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../../../navigation/PageMoveUtil.dart';

class PopupRename extends HookWidget {
  final String title;
  final String hint;
  final String name;
  final Function(String name)? onClicked;

  const PopupRename({
    super.key,
    required this.title,
    required this.hint,
    required this.name,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    final renameText = useState("");

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: getTextTheme(context).b2sb.copyWith(
                  color: getColorScheme(context).colorGray900,
                ),
          ),
          const SizedBox(
            height: 24,
          ),
          OutlineTextField.medium(
            hint: hint,
            controller: useTextEditingController(text: name),
            onChanged: (text) => renameText.value = text,
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
                    onClicked?.call(renameText.value);
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
