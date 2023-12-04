import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/button/NeutralLineButton.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class FailView extends HookWidget {
  final VoidCallback onPressed;

  const FailView({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getMediaQuery(context).size.width,
      height: getMediaQuery(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              getAppLocalizations(context).message_server_error_5xx,
              style: getTextTheme(context).b3m.copyWith(
                    color: getColorScheme(context).colorGray400,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            NeutralLineButton.mediumRound100Icon(
              leftIcon: SvgPicture.asset(
                "assets/imgs/icon_refresh.svg",
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  getColorScheme(context).black,
                  BlendMode.srcIn,
                ),
              ),
              content: getAppLocalizations(context).common_refresh,
              isActivated: true,
              onPressed: () => onPressed.call(),
            )
          ],
        ),
      ),
    );
  }
}
