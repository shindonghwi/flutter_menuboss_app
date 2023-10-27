import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/features/media_content/provider/MediaContentsCartProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

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
                getAppLocalizations(context).common_total_duration,
                style: getTextTheme(context).b3sb.copyWith(
                      color: getColorScheme(context).colorGray900,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  StringUtil.formatDuration(totalDuration.value),
                  style: getTextTheme(context).b3sb.copyWith(
                        color: getColorScheme(context).colorGray500,
                      ),
                ),
              ),
            ],
          ),
          PrimaryFilledButton.xSmallRound4Icon(
            leftIcon: SvgPicture.asset(
              "assets/imgs/icon_plus_1.svg",
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(
                getColorScheme(context).white,
                BlendMode.srcIn,
              ),
            ),
            content: getAppLocalizations(context).blank_message_content_add_content,
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
