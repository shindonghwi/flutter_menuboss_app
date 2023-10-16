import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/components/button/NeutralLineButton.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

class PopupChangeDuration extends HookWidget {
  final String hour;
  final String min;
  final String sec;
  final Function(int duration)? onClicked;

  const PopupChangeDuration({
    super.key,
    required this.hour,
    required this.min,
    required this.sec,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    const size = 3;
    final controllers = List.generate(size, (index) {
      return index == 0
          ? useTextEditingController(text: hour)
          : index == 1
              ? useTextEditingController(text: min)
              : useTextEditingController(text: sec);
    });
    final focusNodes = List.generate(size, (_) => useFocusNode());
    final currentFocusIndex = useState(2);

    final isCompleted = useState<bool>(false);

    useEffect(() {
      void checkCompletion() {
        bool completed = controllers.every((controller) => controller.text.length == 2);
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

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(focusNodes[2]);
      });
      return null;
    }, []);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          getAppLocalizations(context).popup_change_duration_title,
          style: getTextTheme(context).b2b.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
        ),
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(size, (index) {
              return Container(
                width: 32,
                margin: EdgeInsets.only(left: index == 0 ? 0 : 12, right: index == 2 ? 0 : 12),
                child: TextField(
                  controller: controllers[index],
                  focusNode: focusNodes[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 2,
                  style: getTextTheme(context).s2b.copyWith(
                        color: getColorScheme(context).colorGray900,
                      ),
                  decoration: InputDecoration(
                    hintText: "00",
                    hintStyle: getTextTheme(context).s2b.copyWith(
                          color: getColorScheme(context).colorGray400,
                        ),
                    counterText: '',
                    enabledBorder: currentFocusIndex.value == index
                        ? UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: getColorScheme(context).colorGray900,
                              width: 2,
                            ),
                          )
                        : InputBorder.none,
                    focusedBorder: currentFocusIndex.value == index
                        ? UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: getColorScheme(context).colorGray900,
                              width: 2,
                            ),
                          )
                        : InputBorder.none,
                  ),
                  onChanged: (value) {
                    if (value.length == 2 && index < size - 1) {
                      // 입력한 값의 길이가 2이고 마지막 필드가 아닌 경우
                      FocusScope.of(context).requestFocus(focusNodes[index + 1]); // 다음 필드로 초점 이동
                      currentFocusIndex.value = index + 1;
                    }
                  },
                ),
              );
            }),
          ),
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
                  onClicked?.call(
                    StringUtil.convertToSeconds(
                      int.parse(controllers[0].text),
                      int.parse(controllers[1].text),
                      int.parse(controllers[2].text),
                    ),
                  );
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
