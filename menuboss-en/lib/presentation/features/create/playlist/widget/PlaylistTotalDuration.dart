import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/features/media_content/provider/MediaContentsCartProvider.dart';
import 'package:menuboss_common/components/button/PrimaryFilledButton.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/strings.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

class PlaylistTotalDuration extends HookConsumerWidget {
  const PlaylistTotalDuration({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaCart = ref.watch(mediaContentsCartProvider);
    final totalDuration = useState<double>(0);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        totalDuration.value = mediaCart.isNotEmpty
            ? mediaCart.map((e) => e.property?.duration ?? 0.0).reduce(
                (value, element) {
                  return value + element;
                },
              )
            : 0.0;
      });
      return null;
    }, [mediaCart]);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 12, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                Strings.of(context).commonTotalDuration,
                style: getTextTheme(context).b3m.copyWith(
                      color: getColorScheme(context).colorGray900,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  StringUtil.formatDuration(totalDuration.value),
                  style: getTextTheme(context).b3m.copyWith(
                        color: getColorScheme(context).colorGray500,
                      ),
                ),
              ),
            ],
          ),
          if (mediaCart.isNotEmpty)
            PrimaryFilledButton.xSmallRound4Icon(
              leftIcon: LoadSvg(
                path: "assets/imgs/icon_plus_1.svg",
                width: 16,
                height: 16,
                color: getColorScheme(context).white,
              ),
              content: Strings.of(context).blankMessageContentAddContent,
              isActivated: true,
              onPressed: () {
                Navigator.push(
                  context,
                  nextSlideVerticalScreen(
                    RoutingScreen.MediaContent.route,
                    fullScreen: true,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
