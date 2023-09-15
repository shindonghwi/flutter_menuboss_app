import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetModifySelector.dart';
import 'package:menuboss/presentation/components/commons/MoreButton.dart';
import 'package:menuboss/presentation/components/loader/LoadImage.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/components/popup/CommonPopup.dart';
import 'package:menuboss/presentation/components/popup/PopupDelete.dart';
import 'package:menuboss/presentation/components/popup/PopupRename.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

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
        iconWidget = SvgPicture.asset(
          "assets/imgs/icon_folder.svg",
          width: 60,
          height: 60,
        );
      case "image":
      case "video":
        iconWidget = SizedBox(
          width: 60,
          height: 60,
          child: LoadImage(
            tag: item.mediaId.toString(),
            url: item.thumbnailUrl,
            type: ImagePlaceholderType.Small,
          ),
        );
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
              debugPrint("type: $type, text: $text");
              if (type == ModifyType.Delete) {
                CommonPopup.showPopup(
                  context,
                  child: PopupDelete(onClicked: () => onRemove.call()),
                );
              } else if (type == ModifyType.Rename) {
                CommonPopup.showPopup(
                  context,
                  child: PopupRename(
                    hint: getAppLocalizations(context).popup_rename_media_hint,
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
    String content = "";
    if (code == "image" || code == "video") {
      content = "$code - (${StringUtil.formatBytesToMegabytes(item.size ?? 0)})";
    } else if (code == "folder") {
      content = "${item.count} File (${StringUtil.formatBytesToMegabytes(item.size ?? 0)})";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          item.name.toString(),
          style: getTextTheme(context).b1sb.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        !CollectionUtil.isNullEmptyFromString(content)
            ? Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  content,
                  style: getTextTheme(context).b3m.copyWith(
                        color: getColorScheme(context).colorGray500,
                      ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
