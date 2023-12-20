import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../ui/strings.dart';
import '../../utils/Common.dart';
import '../../utils/dto/Pair.dart';
import '../button/NeutralLineButton.dart';
import '../button/PrimaryFilledButton.dart';
import '../toast/Toast.dart';
import '../utils/Clickable.dart';

class BottomSheetTimeSetting extends HookWidget {
  final String startTime;
  final String endTime;

  final Function(String startTime, String endTime) callback;

  const BottomSheetTimeSetting({
    Key? key,
    required this.startTime,
    required this.endTime,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isFocusStartTime = useState(true);

    final startHour = int.parse(startTime.split(':')[0]);
    final startMinute = int.parse(startTime.split(':')[1]);
    final endHour = int.parse(endTime.split(':')[0]);
    final endMinute = int.parse(endTime.split(':')[1]);

    final timeInfoState = [
      Pair(useState(startHour), useState(startMinute)),
      Pair(useState(endHour), useState(endMinute))
    ];

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
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        _TimeSelector(isFocusStartTime: isFocusStartTime, timeInfoState: timeInfoState),
        _NumberPickers(isFocusStartTime: isFocusStartTime, timeInfoState: timeInfoState),
        _ButtonGroups(onPressed: (isOkClick) {
          if (!isOkClick) {
            Navigator.of(context).pop();
            return;
          } else {
            final startInfo = timeInfoState.first;
            final endInfo = timeInfoState.last;

            // 시작 시간이 앞서는걸 방지
            if (startInfo.first.value > endInfo.first.value) {
              Toast.showError(context, Strings.of(context).messageTimeSettingPrecede);
              return;
            } else if ((startInfo.first.value == endInfo.first.value) &&
                (startInfo.second.value >= endInfo.second.value)) {
              Toast.showError(context, Strings.of(context).messageTimeSettingPrecede);
              return;
            }

            if (isOkClick) {
              Navigator.of(context).pop();
              final startTime =
                  "${startInfo.first.value.toString().padLeft(2, '0')}:${startInfo.second.value.toString().padLeft(2, '0')}";
              final endTime =
                  "${endInfo.first.value.toString().padLeft(2, '0')}:${endInfo.second.value.toString().padLeft(2, '0')}";
              callback.call(startTime, endTime);
            }
          }
        })
      ],
    );
  }
}

class _TimeSelector extends HookWidget {
  final ValueNotifier<bool> isFocusStartTime;
  final List<Pair<ValueNotifier<int>, ValueNotifier<int>>> timeInfoState;

  const _TimeSelector({
    super.key,
    required this.isFocusStartTime,
    required this.timeInfoState,
  });

  @override
  Widget build(BuildContext context) {
    final startInfo = timeInfoState.first;
    final endInfo = timeInfoState.last;

    return SizedBox(
      width: double.infinity,
      height: 80,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Clickable(
              onPressed: () => isFocusStartTime.value = true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Start Time",
                    style: getTextTheme(context).b2sb.copyWith(
                          color: isFocusStartTime.value
                              ? getColorScheme(context).colorPrimary500
                              : getColorScheme(context).colorGray200,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      "${startInfo.first.value.toString().padLeft(2, '0')}:${startInfo.second.value.toString().padLeft(2, '0')}",
                      style: getTextTheme(context).b2sb.copyWith(
                            color: isFocusStartTime.value
                                ? getColorScheme(context).colorPrimary500
                                : getColorScheme(context).colorGray200,
                          ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Clickable(
              onPressed: () => isFocusStartTime.value = false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "End Time",
                    style: getTextTheme(context).b2sb.copyWith(
                          color: !isFocusStartTime.value
                              ? getColorScheme(context).colorPrimary500
                              : getColorScheme(context).colorGray200,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      "${endInfo.first.value.toString().padLeft(2, '0')}:${endInfo.second.value.toString().padLeft(2, '0')}",
                      style: getTextTheme(context).b2sb.copyWith(
                            color: !isFocusStartTime.value
                                ? getColorScheme(context).colorPrimary500
                                : getColorScheme(context).colorGray200,
                          ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _NumberPickers extends StatelessWidget {
  final ValueNotifier<bool> isFocusStartTime;
  final List<Pair<ValueNotifier<int>, ValueNotifier<int>>> timeInfoState;

  const _NumberPickers({
    super.key,
    required this.isFocusStartTime,
    required this.timeInfoState,
  });

  @override
  Widget build(BuildContext context) {
    final startInfo = timeInfoState.first;
    final endInfo = timeInfoState.last;

    final layerTransparentList = [
      // 상단에서 포지션, 투명도
      Pair(0, 0.6), // 1번 아이템
      Pair(0.1, 0.5),

      Pair(0.2, 0.3), // 2번 아이템
      Pair(0.3, 0.2),

      Pair(0.4, 0), // 3번 아이템
      Pair(0.5, 0),

      Pair(0.6, 0.2), // 4번 아이템
      Pair(0.7, 0.3),

      Pair(0.8, 0.5), // 5번 아이템
      Pair(0.9, 0.6),
    ];

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 210,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: NumberPicker(
                  infiniteLoop: true,
                  value: isFocusStartTime.value ? startInfo.first.value : endInfo.first.value,
                  minValue: 0,
                  maxValue: 23,
                  itemCount: 5,
                  selectedTextStyle: getTextTheme(context).b2sb.copyWith(
                        color: getColorScheme(context).colorGray900,
                      ),
                  textStyle: getTextTheme(context).b2m.copyWith(
                        color: getColorScheme(context).colorGray900.withOpacity(0.5),
                      ),
                  zeroPad: true,
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: getColorScheme(context).colorGray300,
                        width: 1.5,
                      ),
                    ),
                  ),
                  itemWidth: getMediaQuery(context).size.width * 0.18,
                  itemHeight: getMediaQuery(context).size.height * 0.045,
                  onChanged: (int value) {
                    if (isFocusStartTime.value) {
                      startInfo.first.value = value;
                    } else {
                      endInfo.first.value = value;
                    }
                  },
                ),
              ),
              const SizedBox(
                width: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: NumberPicker(
                  infiniteLoop: true,
                  value: isFocusStartTime.value ? startInfo.second.value : endInfo.second.value,
                  minValue: 0,
                  maxValue: 59,
                  itemCount: 5,
                  selectedTextStyle: getTextTheme(context).b2sb.copyWith(
                        color: getColorScheme(context).colorGray900,
                      ),
                  textStyle: getTextTheme(context).b2m.copyWith(
                        color: getColorScheme(context).colorGray900.withOpacity(0.5),
                      ),
                  zeroPad: true,
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: getColorScheme(context).colorGray300,
                        width: 1.5,
                      ),
                    ),
                  ),
                  itemWidth: getMediaQuery(context).size.width * 0.18,
                  itemHeight: getMediaQuery(context).size.height * 0.045,
                  onChanged: (int value) {
                    if (isFocusStartTime.value) {
                      startInfo.second.value = value;
                    } else {
                      endInfo.second.value = value;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        ...layerTransparentList.map((element) {
          return Positioned(
            top: 210 * element.first.toDouble(), // 포지션
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Container(
                height: 210 * 0.2, // 전체 높이의 20%
                color: getColorScheme(context).white.withOpacity(element.second.toDouble()), // 투명도
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}

class _ButtonGroups extends HookWidget {
  final Function(bool) onPressed;

  const _ButtonGroups({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: NeutralLineButton.mediumRound8(
              content: Strings.of(context).commonCancel,
              isActivated: true,
              onPressed: () => onPressed.call(false),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: PrimaryFilledButton.mediumRound8(
              content: Strings.of(context).commonOk,
              isActivated: true,
              onPressed: () => onPressed.call(true),
            ),
          ),
        ],
      ),
    );
  }
}
