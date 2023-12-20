import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/features/create/schedule/provider/ScheduleSaveInfoProvider.dart';
import 'package:menuboss_common/components/textfield/OutlineTextField.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/strings.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

class ScheduleInputName extends HookConsumerWidget {
  final String initTitle;

  const ScheduleInputName({
    super.key,
    required this.initTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saveProvider = ref.read(ScheduleSaveInfoProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.of(context).commonTitle,
            style: getTextTheme(context).b3sb.copyWith(
                  color: getColorScheme(context).colorGray700,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: OutlineTextField.medium(
              controller: useTextEditingController(text: initTitle),
              hint: Strings.of(context).createScheduleTitleInput,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.text,
              showPwVisibleButton: false,
              showSuffixStatusIcon: false,
              onChanged: (name) => saveProvider.changeName(name),
            ),
          ),
        ],
      ),
    );
  }
}
