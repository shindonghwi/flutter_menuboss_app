import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/Clickable/Clickable.dart';
import 'package:menuboss/presentation/components/checkbox/switch/SwitchCheckBox.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

class DetailTvSettingScreen extends HookWidget {
  const DetailTvSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      Pair("Show Tv Name", useState(true)),
      Pair("Display selected TV guideline", useState(true)),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const _AppBar(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 24, bottom: 60),
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
                        Text(item.first),
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

class _AppBar extends StatelessWidget {
  const _AppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Clickable(
            onPressed: () {},
            child: Container(
              color: Colors.red.withOpacity(0.3),
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                "assets/imgs/icon_back.svg",
                width: 24,
                height: 24,
              ),
            ),
          ),
          Text("TV Settings"),
          Clickable(
            onPressed: () {},
            child: Container(
              color: Colors.green.withOpacity(0.3),
              padding: const EdgeInsets.all(8.0),
              child: Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}
