import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/button/FillButton.dart';
import 'package:menuboss/presentation/utils/dto/Triple.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              _Title(),
              _TvList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("My Home"),
                Text("Tv List"),
              ],
            ),
            SizedBox(
              width: 106,
              height: 44,
              child: FillButton.round(
                content: Text("Add TV"),
                isActivated: true,
                onPressed: () {},
              ),
            ),
          ],
        ));
  }
}

class _TvList extends StatelessWidget {
  const _TvList({super.key});

  @override
  Widget build(BuildContext context) {
    final isEmpty = false;
    return isEmpty ? _TvContentEmpty() : _TvContent();
  }
}

class _TvContentEmpty extends StatelessWidget {
  const _TvContentEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/imgs/icon_register_scan.svg",
              width: 120,
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Text(
                "There is no TV list\nAdd TV by scanning QR code",
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TvContent extends StatelessWidget {
  const _TvContent({super.key});

  @override
  Widget build(BuildContext context) {
    List<Triple> items = [
      Triple("hello1", "world1", "sccren1"),
      Triple("hello2", "world2", "sccren2"),
      Triple("hello3", "world3", "sccren3"),
      Triple("hello4", "world4", "sccren4"),
      Triple("hello5", "world5", "sccren5"),
      Triple("hello6", "world36", "sccren6"),
    ];

    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.only(top: 24, bottom: 60),
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 32); // Adjust the height as needed
        },
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Container(
                  width: 340,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(
                    "assets/imgs/image_default.svg",
                    width: 95,
                    height: 48,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 12,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 8),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        child: Text("Screen On"),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      )
                    ],
                  ),
                )
              ]),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(item.first),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(item.second),
              ),
            ],
          );
        },
        itemCount: items.length,
      ),
    );
  }
}
