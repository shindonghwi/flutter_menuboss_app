import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/SimpleMediaContentModel.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetModifySelector.dart';
import 'package:menuboss/presentation/components/commons/MoreButton.dart';
import 'package:menuboss/presentation/components/loader/LoadImage.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/components/popup/CommonPopup.dart';
import 'package:menuboss/presentation/components/popup/PopupChangeDuration.dart';
import 'package:menuboss/presentation/components/popup/PopupDelete.dart';
import 'package:menuboss/presentation/features/media_content/provider/MediaContentsCartProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

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
    final isAvailableChangeDuration = !(type == "video" || type == "folder");

    return Container(
      width: double.infinity,
      color: getColorScheme(context).white,
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
                    child: SvgPicture.asset(
                      "assets/imgs/icon_alignment.svg",
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        getColorScheme(context).colorGray500,
                        BlendMode.srcIn,
                      ),
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
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/imgs/icon_image.svg",
                                    width: 20,
                                    height: 20,
                                    colorFilter: ColorFilter.mode(
                                      getColorScheme(context).colorGray900,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "${item.name}",
                                        style: getTextTheme(context).b2sb.copyWith(
                                              color: getColorScheme(context).colorGray900,
                                            ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  StringUtil.formatDuration(item.property?.duration ?? 0.0),
                                  style: getTextTheme(context).c1sb.copyWith(
                                        color: getColorScheme(context).colorGray500,
                                      ),
                                ),
                              )
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
          GestureDetector(
            onLongPress: () {},
            child: MoreButton(
              items: [
                if (isAvailableChangeDuration) ModifyType.ChangeDuration,
                ModifyType.Delete,
              ],
              onSelected: (type, text) {
                if (type == ModifyType.ChangeDuration) {
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
                } else if (type == ModifyType.Delete) {
                  CommonPopup.showPopup(
                    context,
                    child: PopupDelete(
                      onClicked: () => mediaCartManger.removeItem(item.index ?? -1),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
