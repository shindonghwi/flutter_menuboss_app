import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/data/models/business/ResponseBusinessMemberModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss_common/components/button/PrimaryFilledButton.dart';
import 'package:menuboss_common/components/textfield/OutlineTextField.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/InputFormatterUtil.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

class TeamCreateScreen extends HookWidget {
  final ResponseBusinessMemberModel? item;

  const TeamCreateScreen({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context) {

    final emailState = useTextEditingController(text: item?.email ?? "");
    final nameState = useTextEditingController(text: item?.name ?? "");
    final passwordState = useTextEditingController(text: "");
    final phoneState = useTextEditingController(text: item?.phone ?? "");

    return BaseScaffold(
      appBar: TopBarIconTitleNone(
        content: item == null
            ? getString(context).teamCreateAppbarCreateTitle
            : getString(context).teamCreateAppbarEditTitle,
        onBack: () => popPageWrapper(context: context),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            _Email(
              initValue: item?.email ?? "",
              onChanged: (email) => emailState.text = email,
            ),
            const SizedBox(height: 16),
            _Name(
              initValue: item?.name ?? "",
              onChanged: (name) => nameState.text = name,
            ),
            const SizedBox(height: 16),
            _Password(
              onChanged: (password) => passwordState.text = password,
            ),
            const SizedBox(height: 16),
            _Phone(
              initValue: item?.phone ?? "",
              onChanged: (phone) => phoneState.text = phone,
            ),
            const SizedBox(height: 16),
            _Role(
              onChanged: (phone) => {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: PrimaryFilledButton.largeRound8(
            content: getString(context).commonSave,
            isActivated: true,
            onPressed: () {

            },
          ),
        ),
      ),
    );
  }
}

class _Email extends HookWidget {
  final String initValue;
  final Function(String) onChanged;

  const _Email({
    super.key,
    required this.initValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getString(context).commonEmail,
          style: getTextTheme(context).b3m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.medium(
          controller: useTextEditingController(text: initValue),
          hint: getString(context).teamCreateEmailHint,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          onChanged: (value) => onChanged.call(value),
        ),
      ],
    );
  }
}

class _Name extends HookWidget {
  final String initValue;
  final Function(String) onChanged;

  const _Name({
    super.key,
    required this.initValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getString(context).commonFullName,
          style: getTextTheme(context).b3m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.medium(
          controller: useTextEditingController(text: initValue),
          hint: getString(context).teamCreateNameHint,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          onChanged: (value) => onChanged.call(value),
        ),
      ],
    );
  }
}

class _Password extends HookWidget {
  final Function(String) onChanged;

  const _Password({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getString(context).commonPassword,
          style: getTextTheme(context).b3m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.medium(
          controller: useTextEditingController(text: ""),
          hint: getString(context).teamCreatePasswordHint,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.visiblePassword,
          showPwVisibleButton: true,
          onChanged: (value) => onChanged.call(value),
        ),
      ],
    );
  }
}

class _Phone extends HookWidget {
  final String initValue;
  final Function(String) onChanged;

  const _Phone({
    super.key,
    required this.initValue,
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
          controller: useTextEditingController(text: StringUtil.formatKrPhoneNumber(initValue)),
          hint: getString(context).teamCreatePhoneHint,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.phone,
          inputFormatters: [InputFormatterUtil.krPhoneNumber()],
          onChanged: (value) => onChanged.call(value),
        ),
      ],
    );
  }
}

class _Role extends HookWidget {
  final Function(String) onChanged;

  const _Role({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getString(context).teamCreateRoleSelect,
          style: getTextTheme(context).b3m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.medium(
          controller: useTextEditingController(text: ""),
          hint: getString(context).teamCreatePhoneHint,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.phone,
          onChanged: (value) => onChanged.call(value),
        ),
      ],
    );
  }
}
