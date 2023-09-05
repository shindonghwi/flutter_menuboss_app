import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

enum BlankMessageType {
  ADD_SCREEN,
  NEW_SCHEDULE,
  NEW_PLAYLIST,
  UPLOAD_FILE,
}

class BlankMessage extends HookWidget {
  final BlankMessageType type;
  final VoidCallback onPressed;

  const BlankMessage({
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
          return "assets/imgs/icon_blank_device.svg";
        case BlankMessageType.NEW_SCHEDULE:
          return "assets/imgs/icon_blank_schedule.svg";
        case BlankMessageType.NEW_PLAYLIST:
          return "assets/imgs/icon_blank_playlist.svg";
        case BlankMessageType.UPLOAD_FILE:
          return "assets/imgs/icon_blank_folder.svg";
        default:
          return null;
      }
    }

    final content = getContent();
    final description = getDescription();
    final iconPath = getIconPath();

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
              style: getTextTheme(context).b2m.copyWith(
                    color: getColorScheme(context).colorGray300,
                  ),
              textAlign: TextAlign.center,
            ),
          const SizedBox(
            height: 20,
          ),
          PrimaryFilledButton.smallRound100Icon(
            leftIcon: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: SvgPicture.asset("assets/imgs/icon_plus.svg",
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    getColorScheme(context).white,
                    BlendMode.srcIn,
                  )),
            ),
            content: content.toString(),
            isActivated: true,
            onPressed: () => onPressed.call(),
          )
        ],
      ),
    );
  }
}
