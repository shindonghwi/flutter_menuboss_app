import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/SimpleMediaContentModel.dart';
import 'package:menuboss/presentation/features/media_content/provider/MediaContentsCartProvider.dart';
import 'package:menuboss_common/components/loader/LoadImage.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/placeholder/PlaceholderType.dart';
import 'package:menuboss_common/components/popup/CommonPopup.dart';
import 'package:menuboss_common/components/popup/PopupChangeDuration.dart';
import 'package:menuboss_common/components/popup/PopupDelete.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

class PlaylistContentItem extends HookConsumerWidget {
  final int index;
  final SimpleMediaContentModel item;

  const PlaylistContentItem({
    super.key,
    required this.index,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaCartManger = ref.read(mediaContentsCartProvider.notifier);
    final type = item.type?.toLowerCase();

    String iconWidgetPath = "";

    switch (type) {
      case "image":
        iconWidgetPath = "assets/imgs/icon_image.svg";
        break;
      case "video":
        iconWidgetPath = "assets/imgs/icon_video.svg";
        break;
      case "canvas":
        iconWidgetPath = "assets/imgs/icon_canvas.svg";
        break;
    }

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                ReorderableDragStartListener(
                  index: index,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: LoadSvg(
                      path: "assets/imgs/icon_alignment.svg",
                      width: 20,
                      height: 20,
                      color: getColorScheme(context).colorGray500,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: LoadImage(
                          url: item.property?.imageUrl,
                          type: ImagePlaceholderType.Small,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 0),
                          child: Row(
                            children: [
                              if (!CollectionUtil.isNullEmptyFromString(iconWidgetPath))
                                LoadSvg(
                                  path: iconWidgetPath,
                                  width: 16,
                                  height: 16,
                                  color: getColorScheme(context).colorGray900,
                                ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4.0, right: 12),
                                  child: Text(
                                    "${item.name}",
                                    style: getTextTheme(context).b3sb.copyWith(
                                          color: getColorScheme(context).colorGray900,
                                        ),
                                  ),
                                ),
                              ),
                              Clickable(
                                onPressed: type == "video"
                                    ? null
                                    : () {
                                        final duration = StringUtil.formatDuration(item.property?.duration ?? 0.0);
                                        CommonPopup.showPopup(
                                          context,
                                          child: PopupChangeDuration(
                                            hour: StringUtil.parseDuration(duration).first,
                                            min: StringUtil.parseDuration(duration).second,
                                            sec: StringUtil.parseDuration(duration).third,
                                            onClicked: (duration) {
                                              mediaCartManger.changeDurationItem(item, duration.toDouble());
                                            },
                                          ),
                                        );
                                      },
                                borderRadius: 4.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: type == "video" ? getColorScheme(context).colorGray100 : Colors.transparent,
                                    border: Border.all(
                                      color: getColorScheme(context).colorGray300,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 8.5, vertical: 8),
                                  child: Text(
                                    StringUtil.formatDuration(item.property?.duration ?? 0.0),
                                    style: getTextTheme(context).c1sb.copyWith(
                                          color: type == "video"
                                              ? getColorScheme(context).colorGray400
                                              : getColorScheme(context).colorGray900,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Clickable(
            onPressed: () {
              CommonPopup.showPopup(
                context,
                child: PopupDelete(
                  onClicked: () => mediaCartManger.removeItem(item.index ?? -1),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: LoadSvg(
                path: "assets/imgs/icon_trash.svg",
                width: 20,
                height: 20,
                color: getColorScheme(context).colorGray500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
