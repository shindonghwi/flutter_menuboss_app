import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss_common/components/bottom_sheet/BottomSheetModifySelector.dart';
import 'package:menuboss_common/components/commons/MoreButton.dart';
import 'package:menuboss_common/components/loader/LoadImage.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/placeholder/PlaceholderType.dart';
import 'package:menuboss_common/components/popup/CommonPopup.dart';
import 'package:menuboss_common/components/popup/PopupDelete.dart';
import 'package:menuboss_common/components/popup/PopupRename.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

class ParseMediaItem {
  static String convertTypeSizeFormat(BuildContext context, String? type, int? count, int? size) {
    switch (type?.toLowerCase()) {
      case "image":
        return getString(context).typeMediaSize(
          getString(context).commonImage,
          StringUtil.formatBytesToMegabytes(size ?? 0),
        );
      case "video":
        return getString(context).typeMediaSize(
          getString(context).commonVideo,
          StringUtil.formatBytesToMegabytes(size ?? 0),
        );
      case "folder":
        return getString(context).countFolder(
          count ?? 0,
          StringUtil.formatBytesToMegabytes(size ?? 0),
        );
      case "canvas":
        return getString(context).typeMediaSize(
          getString(context).commonCanvas,
          StringUtil.formatBytesToMegabytes(size ?? 0),
        );
    }
    return "";
  }
}

class MediaItem extends HookWidget {
  final ResponseMediaModel item;
  final Function(String) onRename;
  final VoidCallback onRemove;

  const MediaItem({
    super.key,
    required this.item,
    required this.onRename,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    Widget? iconWidget;

    switch (item.type?.code.toLowerCase()) {
      case "folder":
        iconWidget = LoadSvg(
          path: "assets/imgs/icon_folder.svg",
          width: 60,
          height: 60,
        );
        break;
      case "image":
      case "video":
        iconWidget = SizedBox(
          width: 60,
          height: 60,
          child: LoadImage(
            tag: item.mediaId.toString(),
            url: item.property?.imageUrl,
            type: ImagePlaceholderType.Size_60,
          ),
        );
        break;
    }

    return SizedBox(
      width: double.infinity,
      height: 92,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                if (iconWidget != null) iconWidget,
                const SizedBox(width: 16),
                Expanded(
                  child: _MediaSimpleInfo(item: item),
                ),
              ],
            ),
          ),
          MoreButton(
            items: const [ModifyType.Rename, ModifyType.Delete],
            onSelected: (type, text) {
              if (type == ModifyType.Delete) {
                CommonPopup.showPopup(
                  context,
                  child: PopupDelete(
                    onClicked: () => onRemove.call(),
                  ),
                );
              } else if (type == ModifyType.Rename) {
                CommonPopup.showPopup(
                  context,
                  child: PopupRename(
                    title: getString(context).popupRenameTitle,
                    hint: getString(context).popupRenameMediaHint,
                    name: item.name.toString(),
                    onClicked: (name) => onRename.call(name),
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

class _MediaSimpleInfo extends HookWidget {
  final ResponseMediaModel item;

  const _MediaSimpleInfo({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final code = item.type?.code.toLowerCase();
    String content = ParseMediaItem.convertTypeSizeFormat(
      context,
      code,
      item.property?.count,
      item.property?.size,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          item.name.toString(),
          style: getTextTheme(context).b2m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        !CollectionUtil.isNullEmptyFromString(content)
            ? Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  content,
                  style: getTextTheme(context).b3r.copyWith(
                        color: getColorScheme(context).colorGray500,
                      ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
