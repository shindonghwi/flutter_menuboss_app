import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';

import '../../ui/colors.dart';
import '../../ui/typography.dart';
import '../../utils/Common.dart';
import '../../utils/PageUtil.dart';
import '../button/NeutralLineButton.dart';
import '../button/PrimaryFilledButton.dart';

class PopupForceUpdate extends HookWidget {
  final VoidCallback onClick;

  const PopupForceUpdate({
    super.key,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final isKr = Localizations.localeOf(context).languageCode == "ko";

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 32,
            height: 32,
            color: getColorScheme(context).colorPrimary500,
            child: Align(
              alignment: Alignment.center,
              child: LoadSvg(
                path: "assets/imgs/icon_notification.svg",
                width: 18,
                height: 18,
                color: getColorScheme(context).white,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            isKr ? '업데이트 소식' : 'Exciting Update news!',
            style: getTextTheme(context).b2sb.copyWith(
                  color: getColorScheme(context).colorGray900,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            isKr
                ? '메뉴보스 앱이 업데이트 되었습니다\n새로운 버전을 확인하기 위해 앱 스토어로 이동하세요'
                : 'The Menu Boss App has just received an awesome update. Head to the app store to check out the fresh new version!',
            style: getTextTheme(context).b3m.copyWith(
                  color: getColorScheme(context).colorGray500,
                  overflow: TextOverflow.visible,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            width: double.infinity,
            child: PrimaryFilledButton.mediumRound8(
              content: isKr ? '업데이트' : 'Update now',
              isActivated: true,
              onPressed: () {
                PageUtil.moveStore(context);
                onClick.call();
              },
            ),
          ),
        ],
      ),
    );
  }
}
