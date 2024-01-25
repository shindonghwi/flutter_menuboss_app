import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleText.dart';
import 'package:menuboss_common/components/button/PrimaryFilledButton.dart';
import 'package:menuboss_common/components/textfield/OutlineTextField.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

class MyBusinessScreen extends HookWidget {
  const MyBusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: TopBarIconTitleText(
        content: getString(context).myBusinessAppbarTitle,
        rightText: getString(context).commonSave,
        rightIconOnPressed: () {},
        rightTextActivated: true,
        onBack: () => popPageWrapper(context: context),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            _BusinessName(
              onChanged: (businessName) => {},
            ),
            SizedBox(height: 24),
            _Address(
              onChanged: (code, add1, add2) => {},
            ),
            SizedBox(height: 24),
            _Phone(
              onChanged: (businessName) => {},
            ),
          ],
        ),
      ),
    );
  }
}

class _BusinessName extends HookWidget {
  final Function(String) onChanged;

  const _BusinessName({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getString(context).myBusinessBusinessNameTitle,
          style: getTextTheme(context).b3m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.medium(
          controller: useTextEditingController(text: ""),
          hint: getString(context).myBusinessBusinessNameHint,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          onChanged: (value) => onChanged.call(value),
        ),
      ],
    );
  }
}

class _Address extends HookWidget {
  final Function(String, String, String) onChanged;

  const _Address({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getString(context).commonAddress,
          style: getTextTheme(context).b3m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Flexible(
              flex: 263,
              fit: FlexFit.tight,
              child: OutlineTextField.medium(
                controller: useTextEditingController(text: ""),
                hint: getString(context).commonPostalCode,
                enable: false,
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              flex: 67,
              fit: FlexFit.tight,
              child: PrimaryFilledButton.mediumRound8(
                content: getString(context).commonSearch,
                isActivated: true,
                onPressed: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        OutlineTextField.medium(
          controller: useTextEditingController(text: ""),
          hint: getString(context).commonAddress,
          enable: false,
        ),
        const SizedBox(height: 12),
        OutlineTextField.medium(
          controller: useTextEditingController(text: ""),
          hint: getString(context).myBusinessAddressDetailHint,
        )
      ],
    );
  }
}



class _Phone extends HookWidget {
  final Function(String) onChanged;

  const _Phone({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getString(context).commonPhoneNumber,
          style: getTextTheme(context).b3m.copyWith(
            color: getColorScheme(context).colorGray900,
          ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.medium(
          controller: useTextEditingController(text: ""),
          hint: getString(context).myBusinessPhoneHint,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.phone,
          onChanged: (value) => onChanged.call(value),
        ),
      ],
    );
  }
}
