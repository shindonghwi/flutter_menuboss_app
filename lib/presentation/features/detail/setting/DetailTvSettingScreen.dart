import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleIcon.dart';
import 'package:menuboss/presentation/components/checkbox/switch/SwitchCheckBox.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

class DetailTvSettingScreen extends HookWidget {
  const DetailTvSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      Pair(getAppLocalizations(context).detail_tv_setting_item_show_tv_name, useState(true)),
      Pair(getAppLocalizations(context).detail_tv_setting_item_guideline, useState(true)),
    ];

    return BaseScaffold(
      backgroundColor: getColorScheme(context).white,
      appBar: TopBarIconTitleIcon(
        content: getAppLocalizations(context).detail_tv_setting_appbar_title,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 60),
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 0); // Adjust the height as needed
                },
                itemBuilder: (BuildContext context, int index) {
                  final item = items[index];
                  return Clickable(
                    onPressed: () => item.second.value = !item.second.value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.first,
                          style: getTextTheme(context).b2sb.copyWith(
                                color: getColorScheme(context).colorGray900,
                              ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: SizedBox(
                            width: 43,
                            height: 26,
                            child: SwitchCheckBox(
                              isOn: items[index].second.value,
                              onChanged: (value) {
                                item.second.value = value;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: items.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
