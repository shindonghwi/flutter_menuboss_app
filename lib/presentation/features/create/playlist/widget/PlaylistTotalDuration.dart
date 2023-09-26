import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
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
    final mediaCart = ref.watch(MediaContentsCartProvider);
    final totalDuration = useState<int>(0);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        totalDuration.value = mediaCart.isNotEmpty
            ? mediaCart.map((e) => e.property?.duration ?? 0).reduce(
                (value, element) {
                  return value + element;
                },
              )
            : 0;
      });
      return null;
    }, [mediaCart]);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 2.5, 12, 2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                getAppLocalizations(context).common_total_duration,
                style: getTextTheme(context).b3sb.copyWith(
                      color: getColorScheme(context).colorGray500,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  StringUtil.formatDuration(totalDuration.value),
                  style: getTextTheme(context).b3sb.copyWith(
                        color: getColorScheme(context).colorGray900,
                      ),
                ),
              ),
            ],
          ),
          Clickable(
            onPressed: () {
              Navigator.push(
                context,
                nextSlideHorizontalScreen(
                  RoutingScreen.MediaContent.route,
                  fullScreen: true,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                "assets/imgs/icon_upload_01.svg",
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  getColorScheme(context).colorGray900,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
