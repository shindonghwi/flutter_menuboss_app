import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/ui/Strings.dart';

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
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            Strings.of(context).messageServerError5xx,
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
            content: Strings.of(context).commonRefresh,
            isActivated: true,
            onPressed: () => onPressed.call(),
          )
        ],
      ),
    );
  }
}
