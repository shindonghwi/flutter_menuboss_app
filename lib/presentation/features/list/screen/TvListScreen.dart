import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/Clickable/Clickable.dart';
import 'package:menuboss/presentation/components/checkbox/checkbox/BasicBorderCheckBox.dart';
import 'package:menuboss/presentation/components/checkbox/model/CheckBoxSize.dart';
import 'package:menuboss/presentation/components/checkbox/model/CheckBoxType.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

class TvListScreen extends StatelessWidget {
  const TvListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _AppBar(),
            _Content(),
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
          const Text("Screen List"),
          Clickable(
            onPressed: () {},
            child: Container(
              color: Colors.green.withOpacity(0.3),
              padding: const EdgeInsets.all(8.0),
              child: const Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}

class _Content extends HookWidget {
  const _Content({super.key});

  @override
  Widget build(BuildContext context) {
    final checkedIndex = useState(-1);

    final imageList = [
      "https://m.lgart.com/Down/Perf/202212/%EA%B0%80%EB%A1%9C%EA%B4%91%EA%B3%A01920x1080-3.jpg",
      "https://marketplace.canva.com/EAD2xI0GoM0/1/0/800w/canva-%ED%95%98%EB%8A%98-%EC%95%BC%EC%99%B8-%EC%9E%90%EC%97%B0-%EC%98%81%EA%B0%90-%EC%9D%B8%EC%9A%A9%EB%AC%B8-%EB%8D%B0%EC%8A%A4%ED%81%AC%ED%86%B1-%EB%B0%B0%EA%B2%BD%ED%99%94%EB%A9%B4-CQJp-Sw9JRs.jpg",
      "https://blog.kakaocdn.net/dn/9Yg2I/btqNJwwHIUS/WNhMAC34BopDSvpKmhy9X0/img.jpg",
      "https://mblogthumb-phinf.pstatic.net/MjAxOTA3MjlfMjAx/MDAxNTY0NDAxNjEzNDgy.jrcSPgSZ1C52bTn0Lt9fhdX7qFPUts6qI7bp17GcjVsg.CfQRIEKV2qNwFFH-29TuveeZhB5PtgjyRzZoQ0dessUg.JPEG.msme3/940581-popular-disney-wallpaper-for-computer-1920x1080-for-iphone-5.jpg?type=w800",
      "https://www.10wallpaper.com/wallpaper/2560x1600/1702/Sea_dawn_nature_sky-High_Quality_Wallpaper_2560x1600.jpg",
      "https://blog.kakaocdn.net/dn/daPJMD/btqCinzhh9J/akDK6BMiG3QKH3XWXwobx1/img.jpg",
    ];

    final items = List.generate(
      10,
      (index) => Pair("Screen ${index + 1}", imageList..shuffle()),
    );

    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 33, bottom: 60),
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 24); // Adjust the height as needed
        },
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Clickable(
                onPressed: () {
                  if (checkedIndex.value == index) {
                    checkedIndex.value = -1;
                    return;
                  }
                  checkedIndex.value = index;
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 12),
                      child: BasicBorderCheckBox(
                        isChecked: checkedIndex.value == index,
                        size: CheckBoxSize.Normal,
                        type: CheckBoxType.Circle,
                        onChange: (value) {
                          if (checkedIndex.value == index) {
                            checkedIndex.value = -1;
                            return;
                          }
                          checkedIndex.value = index;
                        },
                      ),
                    ),
                    const SizedBox(width: 8), // Add some spacing
                    Text(item.first),
                  ],
                ),
              ),
              const SizedBox(height: 8), // Add some spacing
              Container(
                height: 150, // Set a fixed height for the image row
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 12); // Adjust the width as needed
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final imageUrl = item.second[index];
                    return Container(
                      width: 255,
                      height: 150,
                      color: const Color(0xFFF5F5F5),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                  itemCount: item.second.length,
                ),
              ),
            ],
          );
        },
        itemCount: items.length,
      ),
    );
  }
}
