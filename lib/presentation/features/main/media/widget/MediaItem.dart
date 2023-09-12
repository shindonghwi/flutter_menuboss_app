import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetModifySelector.dart';
import 'package:menuboss/presentation/components/commons/MoreButton.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/components/popup/CommonPopup.dart';
import 'package:menuboss/presentation/components/popup/PopupDelete.dart';
import 'package:menuboss/presentation/components/popup/PopupRename.dart';
import 'package:menuboss/presentation/features/main/media/model/MediaModel.dart';
import 'package:menuboss/presentation/features/main/media/model/MediaType.dart';
import 'package:menuboss/presentation/features/main/media/provider/MediaListProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class MediaItem extends HookConsumerWidget {
  final MediaModel item;
  final GlobalKey<AnimatedListState> listKey;

  const MediaItem({
    super.key,
    required this.item,
    required this.listKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaProvider = ref.read(mediaListProvider.notifier);
    final Widget iconWidget;

    switch (item.type) {
      case MediaType.FOLDER:
        iconWidget = SvgPicture.asset(
          "assets/imgs/icon_folder.svg",
          width: 60,
          height: 60,
        );
      case MediaType.IMAGE:
        iconWidget = ImagePlaceholder(type: ImagePlaceholderType.Small);
      case MediaType.VIDEO:
        iconWidget = ImagePlaceholder(type: ImagePlaceholderType.Small);
    }

    return SizedBox(
      width: double.infinity,
      height: 92,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              iconWidget,
              const SizedBox(width: 16),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.fileName,
                    style: getTextTheme(context).b1sb.copyWith(
                          color: getColorScheme(context).colorGray900,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${item.folderCount} File (${item.size})",
                    style: getTextTheme(context).b1sb.copyWith(
                          color: getColorScheme(context).colorGray500,
                        ),
                  ),
                ],
              ),
            ],
          ),
          MoreButton(
            items: const [ModifyType.Rename, ModifyType.Delete],
            onSelected: (type, text) {
              debugPrint("type: $type, text: $text");
              if (type == ModifyType.Delete) {
                CommonPopup.showPopup(
                  context,
                  child: PopupDelete(
                    onClicked: (isCompleted) {
                      if (isCompleted) {
                        mediaProvider.removeItem(item, listKey);
                      }
                    },
                  ),
                );
              } else if (type == ModifyType.Rename) {
                CommonPopup.showPopup(
                  context,
                  child: PopupRename(
                    hint: getAppLocalizations(context).popup_rename_media_hint,
                    onClicked: (name) {},
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
