import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/components/loader/LoadImage.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/features/main/playlists/provider/PlaylistProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class PlayListItem extends HookConsumerWidget {
  final ResponsePlaylistModel item;
  final GlobalKey<AnimatedListState> listKey;

  const PlayListItem({
    super.key,
    required this.item,
    required this.listKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playListProvider = ref.read(PlayListProvider.notifier);
    final contentTypes = item.property?.contentTypes ?? [];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LoadImage(url: item.property?.imageUrl, type: ImagePlaceholderType.Normal),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.name,
                        style: getTextTheme(context).b2sb.copyWith(
                              color: getColorScheme(context).colorGray900,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          "Updated: ${item.updatedAt}",
                          style: getTextTheme(context).c1m.copyWith(
                                color: getColorScheme(context).colorGray500,
                              ),
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: contentTypes.map((e) {
                              return Container(
                                margin: const EdgeInsets.only(right: 4),
                                child: _ContentTypeImage(code: e.code),
                              );
                            }).toList(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              "${item.property?.count} pages",
                              style: getTextTheme(context).c1m.copyWith(
                                    color: getColorScheme(context).colorGray500,
                                  ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          PrimaryFilledButton.extraSmallRound100(
            content: getAppLocalizations(context).common_apply,
            isActivated: true,
            onPressed: () {
              Navigator.push(
                context,
                nextSlideHorizontalScreen(RoutingScreen.ApplyDevice.route),
              );
            },
          )
        ],
      ),
    );
  }
}

class _ContentTypeImage extends StatelessWidget {
  final String code;

  const _ContentTypeImage({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    var typeCode = code.toLowerCase();
    var iconPath = "";

    switch (typeCode) {
      case "image":
        iconPath = "assets/imgs/icon_image.svg";
      case "video":
        iconPath = "assets/imgs/icon_video.svg";
      case "canvas":
        iconPath = "assets/imgs/icon_canvas.svg";
    }

    return SvgPicture.asset(
      iconPath,
      width: 16,
      height: 16,
      colorFilter: ColorFilter.mode(
        getColorScheme(context).colorGray500,
        BlendMode.srcIn,
      ),
    );
  }
}
