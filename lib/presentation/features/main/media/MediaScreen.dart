import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleIcon.dart';
import 'package:menuboss/presentation/components/blank/BlankMessage.dart';
import 'package:menuboss/presentation/components/button/FilterButton.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/FilePickerUtil.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

class MediaScreen extends HookWidget implements FilePickerListener {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: TopBarIconTitleIcon(
        leadingIsShow: false,
        content: getAppLocalizations(context).main_navigation_menu_media,
        suffixIcons: [
          Pair("assets/imgs/icon_new_folder.svg", () {}),
          Pair("assets/imgs/icon_upload.svg", () {}),
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FilterButton(),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: BlankMessage(
                    type: BlankMessageType.UPLOAD_FILE,
                    onPressed: () => FilePickerUtil.pickFile(this),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onSelectedImage(XFile file) {
    /// TODO: 이미지 업로드 기능 구현
  }

  @override
  void onSelectedVideo(XFile file) {
    /// TODO: 비디오 업로드 기능 구현
  }

  @override
  void notAvailableFile() {
    ToastUtil.errorToast("사용 할 수 없는 파일입니다.");
  }
}
