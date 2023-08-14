import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/Clickable/Clickable.dart';

class DetailTvModifyScreen extends StatelessWidget {
  const DetailTvModifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const _AppBar(),
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
          Text("Modify TV Name"),
          Clickable(
            onPressed: () {
            },
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
