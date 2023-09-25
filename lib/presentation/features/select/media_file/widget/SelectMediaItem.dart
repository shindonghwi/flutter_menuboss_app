import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/presentation/components/checkbox/checkbox/BasicBorderCheckBox.dart';
import 'package:menuboss/presentation/components/loader/LoadImage.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/features/select/media_file/provider/SelectMediaCheckListProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

class SelectMediaItem extends HookConsumerWidget {
  final ResponseMediaModel item;

  const SelectMediaItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkListState = ref.watch(SelectMediaCheckListProvider);

    Widget? iconWidget;

    final isFolderType = item.type?.code.toLowerCase() == "folder";

    if (isFolderType) {
      iconWidget = SvgPicture.asset(
        "assets/imgs/icon_folder.svg",
        width: 60,
        height: 60,
      );
    } else {
      iconWidget = SizedBox(
        width: 60,
        height: 60,
        child: LoadImage(
          tag: item.mediaId.toString(),
          url: item.property?.imageUrl,
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
                iconWidget,
                const SizedBox(width: 16),
                Expanded(
                  child: _MediaSimpleInfo(item: item),
                ),
              ],
            ),
          ),
          if (!isFolderType)
            IgnorePointer(
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                child: BasicBorderCheckBox(
                  isChecked: checkListState.contains(item.mediaId),
                  onChange: null,
                ),
              ),
            ),
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
      content = "$code - (${StringUtil.formatBytesToMegabytes(item.property?.size ?? 0)})";
    } else if (code == "folder") {
      content = "${item.property?.count} File (${StringUtil.formatBytesToMegabytes(item.property?.size ?? 0)})";
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
