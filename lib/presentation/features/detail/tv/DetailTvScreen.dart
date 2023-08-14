import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/Clickable/Clickable.dart';
import 'package:menuboss/presentation/features/detail/tv/widget/AllDayModeContent.dart';

class DetailTvScreen extends HookWidget {
  const DetailTvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isAllDayMode = useState(true);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const _AppBar(),
            _ModeTap(isAllDayMode: isAllDayMode),
            _ModeContent(isAllDayMode: isAllDayMode.value),
          ],
        ),
      ),
    );
  }
}

class _ModeTap extends StatelessWidget {
  const _ModeTap({
    super.key,
    required this.isAllDayMode,
  });

  final ValueNotifier<bool> isAllDayMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24, left: 24, right: 24),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Clickable(
              onPressed: () => isAllDayMode.value = !isAllDayMode.value,
              child: Container(
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text("All day Mode"),
                  ),
                ),
                decoration: BoxDecoration(
                  color: isAllDayMode.value ? Colors.red.withOpacity(0.5) : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  border: Border.all(
                    color: isAllDayMode.value ? Colors.red.withOpacity(0.7) : Colors.grey.withOpacity(0.7),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Clickable(
              onPressed: () => isAllDayMode.value = !isAllDayMode.value,
              child: Container(
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text("Schedule Mode"),
                  ),
                ),
                decoration: BoxDecoration(
                  color: !isAllDayMode.value ? Colors.red.withOpacity(0.5) : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border: Border.all(
                    color: !isAllDayMode.value ? Colors.red.withOpacity(0.7) : Colors.grey.withOpacity(0.7),
                  ),
                ),
              ),
            ),
          ),
        ],
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
          Row(
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
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text("TV-12378423"),
              ),
            ],
          ),
          Row(
            children: [
              Clickable(
                onPressed: () {
                  Navigator.push(
                    context,
                    nextSlideScreen(RoutingScreen.DetailTvModify.route),
                  );
                },
                child: Container(
                  color: Colors.red.withOpacity(0.3),
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    "assets/imgs/icon_setting.svg",
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              Clickable(
                onPressed: () {
                  Navigator.push(
                    context,
                    nextSlideScreen(RoutingScreen.DetailTvSetting.route),
                  );
                },
                child: Container(
                  color: Colors.green.withOpacity(0.3),
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    "assets/imgs/icon_setting.svg",
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _ModeContent extends StatelessWidget {
  final bool isAllDayMode;

  const _ModeContent({
    super.key,
    required this.isAllDayMode,
  });

  @override
  Widget build(BuildContext context) {
    return isAllDayMode ? AllDayModeContent() : SizedBox();
  }
}
