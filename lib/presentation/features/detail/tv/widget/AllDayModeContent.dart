import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/Clickable/Clickable.dart';
import 'package:menuboss/presentation/components/button/FillButton.dart';
import 'package:menuboss/presentation/ui/typography.dart';

class AllDayModeContent extends StatelessWidget {
  const AllDayModeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 32, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Basic Exposure", style: Theme.of(context).textTheme.h2sb),
            SizedBox(height: 24),
            _Content(),
            Spacer(),
            _ApplyButton()
          ],
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 340,
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                "assets/imgs/image_default.svg",
                width: 95,
                height: 48,
                fit: BoxFit.scaleDown,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("Hello"),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text("World"),
                  ),
                ],
              ),
              Clickable(
                onPressed: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12.5),
                  child: Text("Edit"),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _ApplyButton extends StatelessWidget {
  const _ApplyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: FillButton.round(
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text("Apply"),
        ),
        isActivated: true,
      ),
    );
  }
}
