import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../ui/colors.dart';
import '../../ui/typography.dart';
import '../../utils/Common.dart';
import '../../utils/StringUtil.dart';
import '../button/NeutralLineButton.dart';
import '../button/PrimaryFilledButton.dart';

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
    final isKr = Localizations.localeOf(context).languageCode == "ko";
    const size = 3;
    final controllers = List.generate(size, (index) {
      return index == 0
          ? useTextEditingController(text: hour == '00' ? "" : hour)
          : index == 1
              ? useTextEditingController(text: min == '00' ? "" : min)
              : useTextEditingController(text: sec == '00' ? "" : sec);
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

    debugPrint("c : ${currentFocusIndex.value}");

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          isKr ? '미디어의 지속 시간을 입력하세요' : 'Please enter the duration\nof the media',
          style: getTextTheme(context).b2sb.copyWith(
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
              return Row(
                children: [
                  SizedBox(
                    width: 32,
                    child: Column(
                      children: [
                        TextField(
                          controller: controllers[index],
                          focusNode: focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 2,
                          style: getTextTheme(context).s2b.copyWith(
                                color: index == currentFocusIndex.value
                                    ? getColorScheme(context).colorGray900
                                    : getColorScheme(context).colorGray400,
                              ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 10),
                            hintText: "00",
                            hintStyle: getTextTheme(context).s2b.copyWith(
                                  color: getColorScheme(context).colorGray400,
                                ),
                            counterText: '',
                            border: InputBorder.none,
                          ),
                          onTap: () {
                            currentFocusIndex.value = index;
                          },
                          onChanged: (value) {
                            if (value.length == 2 && index < size - 1) {
                              // 입력한 값의 길이가 2이고 마지막 필드가 아닌 경우
                              FocusScope.of(context)
                                  .requestFocus(focusNodes[index + 1]); // 다음 필드로 초점 이동
                              currentFocusIndex.value = index + 1;
                            }
                          },
                          textAlignVertical: TextAlignVertical.bottom,
                        ),
                        if (index == currentFocusIndex.value)
                          Container(
                            width: 32,
                            height: 2,
                            color: index == currentFocusIndex.value
                                ? getColorScheme(context).colorGray900
                                : getColorScheme(context).colorGray400,
                          ),
                      ],
                    ),
                  ),
                  if (index < size - 1)
                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Text(
                        ":",
                        style: getTextTheme(context).s1b.copyWith(
                              color: getColorScheme(context).colorGray400,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
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
                content: isKr ? '취소' : 'Cancel',
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
                content: isKr ? '확인' : 'Ok',
                isActivated: true,
                onPressed: () {
                  onClicked?.call(
                    StringUtil.convertToSeconds(
                      controllers[0].text.isNotEmpty ? int.parse(controllers[0].text) : 0,
                      controllers[1].text.isNotEmpty ? int.parse(controllers[1].text) : 0,
                      controllers[2].text.isNotEmpty ? int.parse(controllers[2].text) : 0,
                    ),
                  );
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
