import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleIcon.dart';
import 'package:menuboss/presentation/components/blank/BlankMessage.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetFilterSelector.dart';
import 'package:menuboss/presentation/components/button/FilterButton.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/utils/ClickableScale.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/FilePickerUtil.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

import 'model/MediaItem.dart';
import 'model/MediaType.dart';
import 'widget/MediaFolder.dart';
import 'widget/MediaImage.dart';
import 'widget/MediaVideo.dart';

GlobalKey<T> useGlobalKey<T extends State<StatefulWidget>>() {
  final key = useMemoized(() => GlobalKey<T>(), []);
  return key;
}

class MediaScreen extends HookWidget implements FilePickerListener {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final typeList = [MediaType.FOLDER, MediaType.IMAGE, MediaType.VIDEO];

    final _listKey = useGlobalKey<AnimatedListState>();

    // 랜덤으로 아이템 생성
    List<MediaItem> generateItems(int count) {
      List<MediaItem> items = [];

      for (int i = 0; i < count; i++) {
        MediaType type = typeList[random.nextInt(typeList.length)];

        switch (type) {
          case MediaType.FOLDER:
            final size = random.nextInt(10);
            items.add(MediaItem(MediaType.FOLDER, "New folder $i", 1 + random.nextInt(10), "${size}MB"));
            break;
          case MediaType.IMAGE:
            final size = (0.01 + random.nextDouble() * (10.0 - 0.01)).toStringAsFixed(1);
            items.add(MediaItem(MediaType.IMAGE, "Image $i", 0, "${size}MB"));
            break;
          case MediaType.VIDEO:
            final size = (0.01 + random.nextDouble() * (10.0 - 0.01)).toStringAsFixed(1);
            items.add(MediaItem(MediaType.VIDEO, "Video $i", 0, "${size}MB"));
            break;
        }
      }

      return items;
    }

    // 사용자가 정의한 필터로 정렬
    List<MediaItem> sortByName(List<MediaItem> items, FilterType type) {
      items.sort((a, b) {
        // 폴더가 항상 상위에 오게 한다.
        if (a.type == MediaType.FOLDER && b.type != MediaType.FOLDER) return -1;
        if (a.type != MediaType.FOLDER && b.type == MediaType.FOLDER) return 1;

        if (type == FilterType.NameAsc) {
          return a.fileName.compareTo(b.fileName);
        } else {
          return b.fileName.compareTo(a.fileName);
        }
      });
      return items;
    }

    final items = useState(sortByName(generateItems(10), FilterType.NameAsc));

    void addItem(MediaItem item) {
      _listKey.currentState?.insertItem(0, duration: const Duration(milliseconds: 500));
      items.value = [item, ...items.value];
    }

    return BaseScaffold(
      appBar: TopBarIconTitleIcon(
        leadingIsShow: false,
        content: getAppLocalizations(context).main_navigation_menu_media,
        suffixIcons: [
          Pair("assets/imgs/icon_new_folder.svg", () {
            addItem(MediaItem(MediaType.FOLDER, "New folder ${items.value.length + 1}", 1 + random.nextInt(10),
                "${random.nextInt(10)}MB"));
          }),
          Pair("assets/imgs/icon_upload.svg", () {}),
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FilterButton(
                    onSelected: (type, text) {
                      items.value = sortByName([...items.value], type);
                    },
                  ),
                ),
              ),
              items.value.isNotEmpty
                  ? Expanded(
                      child: AnimatedList(
                        key: _listKey,
                        initialItemCount: items.value.length,
                        itemBuilder: (context, index, animation) {
                          final item = items.value[index];
                          return ClickableScale(
                            onPressed: () {
                              Navigator.push(
                                context,
                                nextSlideScreen(RoutingScreen.DetailMediaInformation.route),
                              );
                            },
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, -0.15),
                                end: Offset.zero,
                              ).animate(animation),
                              child: FadeTransition(
                                opacity: animation,
                                child: _buildListItem(item),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Expanded(
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

  Widget _buildListItem(MediaItem item) {
    if (item.type == MediaType.FOLDER) {
      return MediaFolder(item: item);
    } else if (item.type == MediaType.IMAGE) {
      return MediaImage(item: item);
    } else if (item.type == MediaType.VIDEO) {
      return MediaVideo(item: item);
    } else {
      throw Exception('Unsupported media type');
    }
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
