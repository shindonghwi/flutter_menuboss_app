import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';

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
    bool isKr = Localizations.localeOf(context).languageCode == "ko";

    String? getContent() {
      switch (type) {
        case BlankMessageType.ADD_SCREEN:
          return isKr ? "TV 추가" : "New screen";
        case BlankMessageType.ADD_CONTENT:
          return isKr ? "콘텐츠 추가" : "Add content";
        case BlankMessageType.ADD_CANVAS:
          return isKr ? "캔버스 추가" : "Add canvas";
        case BlankMessageType.NEW_SCHEDULE:
          return isKr ? "시간표 추가" : "New schedule";
        case BlankMessageType.NEW_PLAYLIST:
          return isKr ? "재생목록 추가" : "New playlist";
        case BlankMessageType.UPLOAD_FILE:
          return isKr ? "파일 업로드" : "Upload file";
        default:
          return null;
      }
    }

    String? getDescription() {
      if (onlyButtonMode) return null;
      switch (type) {
        case BlankMessageType.ADD_SCREEN:
          return isKr
              ? "현재 저장된 TV목록이 없습니다\nQR코드 인식을 통해 TV를 만들어주세요"
              : "There are currently no saved screen list\nPlease register the screen through QR code";
        case BlankMessageType.ADD_CONTENT:
          return isKr
              ? "현재 저장된 파일 및 폴더가 없습니다\n파일 또는 폴더를 추가하여 만들어주세요"
              : "There are no current files or folders\nPlease create a file or folder";
        case BlankMessageType.ADD_CANVAS:
          return isKr
              ? "현재 저장된 캔버스 없습니다\n캔버스를 만들어 추가해주세요"
              : "There are currently no saved canvases\nPlease create and add a canvas";
        case BlankMessageType.NEW_SCHEDULE:
          return isKr
              ? "현재 저장된 시간표가 없습니다\n시간표를 추가하여 만들어주세요"
              : "There are currently no saved schedules\nPlease add a schedule to create one";
        case BlankMessageType.NEW_PLAYLIST:
          return isKr
              ? "현재 저장된 재생목록이 없습니다\n재생목록을 추가하여 만들어주세요"
              : "There are currently no saved playlists\nPlease add a playlist to create one";
        case BlankMessageType.UPLOAD_FILE:
          return isKr
              ? "현재 저장된 파일 및 폴더가 없습니다\n파일 또는 폴더를 추가하여 만들어주세요"
              : "There are no current files or folders\nPlease create a file or folder";
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
