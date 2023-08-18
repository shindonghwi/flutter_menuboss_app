import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleText.dart';
import 'package:menuboss/presentation/components/textfield/UnderLineTextField.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class DetailTvModifyScreen extends HookWidget {
  const DetailTvModifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final saveButtonActivated = useState(false);

    return BaseScaffold(
      backgroundColor: getColorScheme(context).white,
      appBar: TopBarIconTitleText(
        content: getAppLocalizations(context).detail_tv_modify_appbar_title,
        rightTextActivated: saveButtonActivated.value,
        rightIconOnPressed: () {},
        rightText: getAppLocalizations(context).common_save,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: UnderLineTextField(
                maxLength: 20,
                controller: useTextEditingController(),
                hint: 'Name',
                onChanged: (value) {
                  saveButtonActivated.value = value.isNotEmpty;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
