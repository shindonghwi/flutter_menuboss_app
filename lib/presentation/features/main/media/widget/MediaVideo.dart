import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleIcon.dart';
import 'package:menuboss/presentation/components/blank/BlankMessage.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetModifySelector.dart';
import 'package:menuboss/presentation/components/bottom_sheet/CommonBottomSheet.dart';
import 'package:menuboss/presentation/components/button/FilterButton.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/components/popup/CommonPopup.dart';
import 'package:menuboss/presentation/components/popup/PopupDelete.dart';
import 'package:menuboss/presentation/components/popup/PopupRename.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/features/main/media/MediaScreen.dart';
import 'package:menuboss/presentation/features/main/media/provider/MediaListProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/FilePickerUtil.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

import '../model/MediaItem.dart';
import 'MediaMoreWidget.dart';

class MediaVideo extends HookConsumerWidget {
  final MediaItem item;
  final GlobalKey<AnimatedListState> listKey;

  const MediaVideo({
    super.key,
    required this.item,
    required this.listKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaProvider = ref.read(mediaListProvider(listKey).notifier);

    return SizedBox(
      width: double.infinity,
      height: 92,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const ImagePlaceholder(type: ImagePlaceholderType.Small),
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
                    "Video - ${item.size}",
                    style: getTextTheme(context).b1sb.copyWith(
                          color: getColorScheme(context).colorGray500,
                        ),
                  ),
                ],
              ),
            ],
          ),
          MediaMoreWidget(
            items: const [ModifyType.Rename, ModifyType.Delete],
            onSelected: (type, text) {
              debugPrint("type: $type, text: $text");
              if (type == ModifyType.Delete) {
                CommonPopup.showPopup(
                  context,
                  child: PopupDelete(
                    onClicked: (isCompleted) {
                      if (isCompleted) {
                        mediaProvider.removeItem(item);
                      }
                    },
                  ),
                );
              } else if (type == ModifyType.Rename) {
                CommonPopup.showPopup(
                  context,
                  child: PopupRename(
                    hint: getAppLocalizations(context).popup_input_new_name,
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
