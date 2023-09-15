import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/components/button/NeutralLineButton.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/components/textfield/OutlineTextField.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class PopupRename extends HookWidget {
  final String hint;
  final Function(String name)? onClicked;

  const PopupRename({
    super.key,
    required this.hint,
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
            getAppLocalizations(context).common_rename,
            style: getTextTheme(context).b2b.copyWith(
                  color: getColorScheme(context).colorGray900,
                ),
          ),
          const SizedBox(
            height: 24,
          ),
          OutlineTextField.small(
            hint: hint,
            onChanged: (text) => renameText.value = text,
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
                child: PrimaryFilledButton.mediumRound8(
                  content: getAppLocalizations(context).common_ok,
                  isActivated: true,
                  onPressed: () {
                    Navigator.pop(context);
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
