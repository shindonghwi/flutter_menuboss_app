import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetModifySelector.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/components/commons/MoreButton.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/components/popup/CommonPopup.dart';
import 'package:menuboss/presentation/components/popup/PopupDelete.dart';
import 'package:menuboss/presentation/components/popup/PopupRename.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/features/main/media/model/MediaModel.dart';
import 'package:menuboss/presentation/features/main/media/model/MediaType.dart';
import 'package:menuboss/presentation/features/main/media/provider/MediaListProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class MediaItemAdd extends HookConsumerWidget {
  final MediaModel item;
  final VoidCallback onFolderTap;

  const MediaItemAdd({
    super.key,
    required this.item,
    required this.onFolderTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Widget iconWidget;

    switch (item.type) {
      case MediaType.FOLDER:
        iconWidget = SvgPicture.asset(
          "assets/imgs/icon_folder.svg",
          width: 60,
          height: 60,
        );
      case MediaType.IMAGE:
        iconWidget = const ImagePlaceholder(type: ImagePlaceholderType.Small);
      case MediaType.VIDEO:
        iconWidget = const ImagePlaceholder(type: ImagePlaceholderType.Small);
    }

    return Clickable(
      onPressed: item.type == MediaType.FOLDER ? () => onFolderTap.call() : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: SizedBox(
          width: double.infinity,
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
              PrimaryFilledButton.extraSmallRound100(
                content: getAppLocalizations(context).common_add,
                isActivated: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
