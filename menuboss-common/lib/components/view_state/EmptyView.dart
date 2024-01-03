import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/ui/Strings.dart';

import '../../ui/colors.dart';
import '../../ui/typography.dart';
import '../../utils/Common.dart';
import '../button/PrimaryFilledButton.dart';

enum BlankMessageType {
  ADD_SCREEN,
  ADD_CONTENT,
  ADD_CANVAS,
  NEW_SCHEDULE,
  NEW_PLAYLIST,
  UPLOAD_FILE,
}

class EmptyView extends HookWidget {
  final BlankMessageType type;
  final bool onlyButtonMode;
  final VoidCallback? onPressed;

  const EmptyView({
    super.key,
    required this.type,
    required this.onPressed,
    this.onlyButtonMode = false,
  });

  @override
  Widget build(BuildContext context) {
    String? getContent() {
      switch (type) {
        case BlankMessageType.ADD_SCREEN:
          return Strings.of(context).blankMessageContentAddScreen;
        case BlankMessageType.ADD_CONTENT:
          return Strings.of(context).blankMessageContentAddContent;
        case BlankMessageType.ADD_CANVAS:
          return Strings.of(context).blankMessageContentAddCanvas;
        case BlankMessageType.NEW_SCHEDULE:
          return Strings.of(context).blankMessageContentNewSchedule;
        case BlankMessageType.NEW_PLAYLIST:
          return Strings.of(context).blankMessageContentNewPlaylist;
        case BlankMessageType.UPLOAD_FILE:
          return Strings.of(context).blankMessageContentUploadFile;
        default:
          return null;
      }
    }

    String? getDescription() {
      if (onlyButtonMode) return null;
      switch (type) {
        case BlankMessageType.ADD_SCREEN:
          return Strings.of(context).blankMessageDescriptionAddScreen;
        case BlankMessageType.ADD_CONTENT:
          return Strings.of(context).blankMessageDescriptionUploadFile;
        case BlankMessageType.ADD_CANVAS:
          return Strings.of(context).blankMessageDescriptionAddCanvas;
        case BlankMessageType.NEW_SCHEDULE:
          return Strings.of(context).blankMessageDescriptionNewSchedule;
        case BlankMessageType.NEW_PLAYLIST:
          return Strings.of(context).blankMessageDescriptionNewPlaylist;
        case BlankMessageType.UPLOAD_FILE:
          return Strings.of(context).blankMessageDescriptionUploadFile;
        default:
          return null;
      }
    }

    String? getIconPath() {
      if (onlyButtonMode) return null;
      switch (type) {
        case BlankMessageType.ADD_SCREEN:
          return "assets/imgs/image_blank_device.svg";
        case BlankMessageType.ADD_CONTENT:
          return "assets/imgs/image_blank_upload.svg";
        case BlankMessageType.ADD_CANVAS:
          return "assets/imgs/image_blank_canvas.svg";
        case BlankMessageType.NEW_SCHEDULE:
          return "assets/imgs/image_blank_schedule.svg";
        case BlankMessageType.NEW_PLAYLIST:
          return "assets/imgs/image_blank_playlist.svg";
        case BlankMessageType.UPLOAD_FILE:
          return "assets/imgs/image_blank_upload.svg";
        default:
          return null;
      }
    }

    String? getButtonIconPath() {
      switch (type) {
        case BlankMessageType.ADD_SCREEN:
          return "assets/imgs/icon_plus_1.svg";
        case BlankMessageType.ADD_CONTENT:
          return "assets/imgs/icon_plus_1.svg";
        case BlankMessageType.ADD_CONTENT:
          return "assets/imgs/icon_plus_1.svg";
        case BlankMessageType.NEW_SCHEDULE:
          return "assets/imgs/icon_plus_1.svg";
        case BlankMessageType.NEW_PLAYLIST:
          return "assets/imgs/icon_plus_1.svg";
        case BlankMessageType.UPLOAD_FILE:
          return "assets/imgs/icon_upload_01.svg";
        default:
          return null;
      }
    }

    final content = getContent();
    final description = getDescription();
    final iconPath = getIconPath();
    final buttonIconPath = getButtonIconPath();

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (iconPath != null)
            LoadSvg(
              path: iconPath,
              width: 60,
              height: 60,
              color: getColorScheme(context).colorGray300,
            ),
          const SizedBox(
            height: 12,
          ),
          if (description != null)
            Text(
              description,
              style: getTextTheme(context).b3m.copyWith(
                    color: getColorScheme(context).colorGray400,
                  ),
              textAlign: TextAlign.center,
            ),
          if (buttonIconPath != null && onPressed != null)
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: PrimaryFilledButton.mediumRound100Icon(
                leftIcon: LoadSvg(
                  path: buttonIconPath,
                  width: 20,
                  height: 20,
                  color: getColorScheme(context).white,
                ),
                content: content.toString(),
                isActivated: true,
                onPressed: () => onPressed?.call(),
              ),
            )
        ],
      ),
    );
  }
}
