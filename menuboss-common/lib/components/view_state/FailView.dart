import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';

import '../../ui/colors.dart';
import '../../ui/typography.dart';
import '../../utils/Common.dart';
import '../button/NeutralLineButton.dart';

class FailView extends HookWidget {
  final VoidCallback onPressed;

  const FailView({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    bool isKr = Localizations.localeOf(context).languageCode == "ko";

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isKr
                ? "데이터를 불러오는 중 오류가 발생했습니다.\n다시 시도해주세요"
                : "An error occurred while loading data.\nPlease use it again",
            style: getTextTheme(context).b3m.copyWith(
                  color: getColorScheme(context).colorGray400,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          NeutralLineButton.mediumRound100Icon(
            leftIcon: LoadSvg(
              path: "assets/imgs/icon_refresh.svg",
              width: 20,
              height: 20,
              color: getColorScheme(context).black,
            ),
            content: isKr ? "새로고침" : "Refresh",
            isActivated: true,
            onPressed: () => onPressed.call(),
          )
        ],
      ),
    );
  }
}
