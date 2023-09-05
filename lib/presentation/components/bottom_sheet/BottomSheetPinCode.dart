import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class BottomSheetPinCode extends HookWidget {
  const BottomSheetPinCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const pinCodeLength = 4;
    final controllers = List.generate(pinCodeLength, (_) => useTextEditingController());
    final focusNodes = List.generate(pinCodeLength, (_) => useFocusNode());

    final isCompleted = useState<bool>(false);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(focusNodes[0]);
      });
      return null;
    }, []);

    useEffect(() {
      void checkCompletion() {
        bool completed = controllers.every((controller) => controller.text.length == 1);
        isCompleted.value = completed;
      }

      for (var controller in controllers) {
        controller.addListener(checkCompletion);
      }

      return () {
        for (var controller in controllers) {
          controller.removeListener(checkCompletion);
        }
      };
    }, [controllers]);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8, bottom: 12),
          width: 44,
          height: 4,
          decoration: BoxDecoration(
            color: getColorScheme(context).colorGray200,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          getAppLocalizations(context).bottom_sheet_pin_code_description,
          style: getTextTheme(context).b1b.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(
          height: 32,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (index) {
            return Container(
              width: 40,
              margin: EdgeInsets.only(left: index == 0 ? 0 : 12, right: index == 3 ? 0 : 12),
              child: TextField(
                controller: controllers[index],
                focusNode: focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: getTextTheme(context).s1b.copyWith(
                      color: getColorScheme(context).colorGray900,
                    ),
                decoration: InputDecoration(
                  counterText: '',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: focusNodes[index].hasFocus
                          ? getColorScheme(context).colorGray900
                          : getColorScheme(context).colorGray300,
                      width: 2,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: getColorScheme(context).colorGray900,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    controllers[index].text = value.substring(value.length - 1);
                    controllers[index].selection =
                        TextSelection.fromPosition(TextPosition(offset: controllers[index].text.length));

                    if (index < 3) {
                      // Move focus to next TextField
                      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                    }
                  }
                },
              ),
            );
          }),
        ),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: PrimaryFilledButton.normalRound10(
              content: getAppLocalizations(context).common_confirm,
              isActivated: isCompleted.value,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}
