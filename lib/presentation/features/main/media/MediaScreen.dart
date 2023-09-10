import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
import 'package:menuboss/presentation/features/main/media/provider/MediaListProvider.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/CustomHook.dart';
import 'package:menuboss/presentation/utils/FilePickerUtil.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

import 'model/MediaModel.dart';
import 'model/MediaType.dart';
import 'widget/MediaFolder.dart';
import 'widget/MediaImage.dart';
import 'widget/MediaVideo.dart';

class MediaScreen extends HookConsumerWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final random = Random();
    final listKey = useState(CustomHook.useGlobalKey<AnimatedListState>()).value;
    final items = ref.watch(mediaListProvider(listKey));
    final mediaProvider = ref.read(mediaListProvider(listKey).notifier);

    useEffect(() {
      // 랜덤으로 아이템 생성
      void generateItems(int count) {
        final typeList = [MediaType.FOLDER, MediaType.IMAGE, MediaType.VIDEO];
        for (int i = 0; i < count; i++) {
          MediaType type = typeList[random.nextInt(typeList.length)];

          switch (type) {
            case MediaType.FOLDER:
              final size = random.nextInt(10);
              mediaProvider.addItem(MediaModel(MediaType.FOLDER, "New folder $i", 1 + random.nextInt(10), "${size}MB"));
              break;
            case MediaType.IMAGE:
              final size = (0.01 + random.nextDouble() * (10.0 - 0.01)).toStringAsFixed(1);
              mediaProvider.addItem(MediaModel(MediaType.IMAGE, "Image $i", 0, "${size}MB"));
              break;
            case MediaType.VIDEO:
              final size = (0.01 + random.nextDouble() * (10.0 - 0.01)).toStringAsFixed(1);
              mediaProvider.addItem(MediaModel(MediaType.VIDEO, "Video $i", 0, "${size}MB"));
              break;
          }
        }

        mediaProvider.sortByName(FilterType.NameAsc);
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        generateItems(10);
      });
      return null;
    }, []);

    return BaseScaffold(
      appBar: TopBarIconTitleIcon(
        leadingIsShow: false,
        content: getAppLocalizations(context).main_navigation_menu_media,
        suffixIcons: [
          Pair("assets/imgs/icon_new_folder.svg", () {
            mediaProvider.addItem(
              MediaModel(
                MediaType.FOLDER,
                "New folder ${items.length + 1}",
                1 + random.nextInt(10),
                "${random.nextInt(10)}MB",
              ),
            );
          }),
          Pair("assets/imgs/icon_upload.svg", () {
            mediaProvider.addItem(
              MediaModel(
                MediaType.IMAGE,
                "New Image ${items.length + 1}",
                1 + random.nextInt(10),
                "${random.nextInt(10)}MB",
              ),
            );
          }),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Align(
                alignment: Alignment.centerRight,
                child: FilterButton(
                  onSelected: (type, text) {
                    mediaProvider.sortByName(type);
                  },
                ),
              ),
            ),
            items.isNotEmpty
                ? Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(24, 0, 12, 0),
                      child: AnimatedList(
                        key: mediaProvider.listKey,
                        initialItemCount: items.length,
                        itemBuilder: (context, index, animation) {
                          final item = items[index];
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
                                child: _buildListItem(item, listKey),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                      child: BlankMessage(
                        type: BlankMessageType.UPLOAD_FILE,
                        onPressed: () => FilePickerUtil.pickFile(
                          onImageSelected: (XFile xfile) {
                            mediaProvider.addItem(
                              MediaModel(
                                MediaType.IMAGE,
                                "New Image ${items.length + 1}",
                                1 + random.nextInt(10),
                                "${random.nextInt(10)}MB",
                              ),
                            );
                          },
                          onVideoSelected: (XFile xfile) {},
                          notAvailableFile: () {
                            ToastUtil.errorToast("사용 할 수 없는 파일입니다.");
                          },
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(MediaModel item, GlobalKey<AnimatedListState> listKey) {
    if (item.type == MediaType.FOLDER) {
      return MediaFolder(item: item, listKey: listKey);
    } else if (item.type == MediaType.IMAGE) {
      return MediaImage(item: item, listKey: listKey);
    } else if (item.type == MediaType.VIDEO) {
      return MediaVideo(item: item, listKey: listKey);
    } else {
      throw Exception('Unsupported media type');
    }
  }
}
