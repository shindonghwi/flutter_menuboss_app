import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/components/Clickable/Clickable.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleIcon.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/features/detail/tv/widget/AllDayModeContent.dart';
import 'package:menuboss/presentation/features/detail/tv/widget/ScheduleModeContent.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

class DetailTvScreen extends HookWidget {
  const DetailTvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isAllDayMode = useState(true);

    return Scaffold(
      backgroundColor: getColorScheme(context).white,
      appBar: TopBarIconTitleIcon(
        content: "Tv",
        suffixIcons: [
          Pair("assets/imgs/icon_edit.svg", () {}),
          Pair("assets/imgs/icon_settings.svg", () {}),
        ],
      ),
      body: Column(
        children: [
          _ModeTap(isAllDayMode: isAllDayMode),
          _ModeContent(isAllDayMode: isAllDayMode.value),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SafeArea(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
          child: PrimaryFilledButton.largeRound(
            content: getAppLocalizations(context).common_apply,
            isActivated: true,
            onPressed: () {},
          ),
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
                decoration: BoxDecoration(
                  color: isAllDayMode.value ? getColorScheme(context).colorSecondary50 : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  border: Border.all(
                    color: isAllDayMode.value
                        ? getColorScheme(context).colorSecondary500
                        : getColorScheme(context).colorGray300,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      getAppLocalizations(context).common_mode_all_day,
                      style: getTextTheme(context).b2sb.copyWith(
                            color: isAllDayMode.value
                                ? getColorScheme(context).colorSecondary500
                                : getColorScheme(context).colorGray300,
                          ),
                    ),
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
                decoration: BoxDecoration(
                  color: !isAllDayMode.value ? getColorScheme(context).colorSecondary50 : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border: Border.all(
                    color: !isAllDayMode.value
                        ? getColorScheme(context).colorSecondary500
                        : getColorScheme(context).colorGray300,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      getAppLocalizations(context).common_mode_schedule,
                      style: getTextTheme(context).b2sb.copyWith(
                            color: !isAllDayMode.value
                                ? getColorScheme(context).colorSecondary500
                                : getColorScheme(context).colorGray300,
                          ),
                    ),
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

class _ModeContent extends StatelessWidget {
  final bool isAllDayMode;

  const _ModeContent({
    super.key,
    required this.isAllDayMode,
  });

  @override
  Widget build(BuildContext context) {
    return isAllDayMode ? const AllDayModeContent() : const ScheduleModeContent();
  }
}
