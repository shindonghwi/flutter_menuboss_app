import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

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
  final VoidCallback? onPressed;

  const EmptyView({
    super.key,
    required this.type,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    String? getContent() {
      switch (type) {
        case BlankMessageType.ADD_SCREEN:
          return getAppLocalizations(context).blank_message_content_add_screen;
        case BlankMessageType.ADD_CONTENT:
          return getAppLocalizations(context).blank_message_content_add_content;
        case BlankMessageType.ADD_CANVAS:
          return getAppLocalizations(context).blank_message_content_add_canvas;
        case BlankMessageType.NEW_SCHEDULE:
          return getAppLocalizations(context).blank_message_content_new_schedule;
        case BlankMessageType.NEW_PLAYLIST:
          return getAppLocalizations(context).blank_message_content_new_playlist;
        case BlankMessageType.UPLOAD_FILE:
          return getAppLocalizations(context).blank_message_content_upload_file;
        default:
          return null;
      }
    }

    String? getDescription() {
      switch (type) {
        case BlankMessageType.ADD_SCREEN:
          return getAppLocalizations(context).blank_message_description_add_screen;
        case BlankMessageType.ADD_CONTENT:
          return getAppLocalizations(context).blank_message_description_add_content;
        case BlankMessageType.ADD_CANVAS:
          return getAppLocalizations(context).blank_message_description_add_canvas;
        case BlankMessageType.NEW_SCHEDULE:
          return getAppLocalizations(context).blank_message_description_new_schedule;
        case BlankMessageType.NEW_PLAYLIST:
          return getAppLocalizations(context).blank_message_description_new_playlist;
        case BlankMessageType.UPLOAD_FILE:
          return getAppLocalizations(context).blank_message_description_upload_file;
        default:
          return null;
      }
    }

    String? getIconPath() {
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
            SvgPicture.asset(
              iconPath,
              width: 60,
              height: 60,
              colorFilter: ColorFilter.mode(
                getColorScheme(context).colorGray300,
                BlendMode.srcIn,
              ),
            ),
          const SizedBox(
            height: 16,
          ),
          if (description != null)
            Text(
              description,
              style: getTextTheme(context).c1m.copyWith(
                    color: getColorScheme(context).colorGray300,
                  ),
              textAlign: TextAlign.center,
            ),
          if (buttonIconPath != null && onPressed != null)
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: PrimaryFilledButton.mediumRound100Icon(
                leftIcon: SvgPicture.asset(
                  buttonIconPath,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    getColorScheme(context).white,
                    BlendMode.srcIn,
                  ),
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
