import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/features/main/media/model/MediaModel.dart';
import 'package:menuboss/presentation/features/main/media/model/MediaType.dart';

import 'MediaItemAdd.dart';

class MediaTab extends HookWidget {
  final VoidCallback onFolderTap;

  const MediaTab({
    super.key,
    required this.onFolderTap,
  });

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    final random = Random();
    final items = useState<List<MediaModel>>([]);

    useEffect(() {
      // 랜덤으로 아이템 생성
      void generateItems(int count) {
        final typeList = [MediaType.FOLDER, MediaType.IMAGE, MediaType.VIDEO];
        for (int i = 0; i < count; i++) {
          MediaType type = typeList[random.nextInt(typeList.length)];

          switch (type) {
            case MediaType.FOLDER:
              final size = random.nextInt(10);
              items.value.add(MediaModel(MediaType.FOLDER, "New folder $i", 1 + random.nextInt(10), "${size}MB"));
              break;
            case MediaType.IMAGE:
              final size = (0.01 + random.nextDouble() * (10.0 - 0.01)).toStringAsFixed(1);
              items.value.add(MediaModel(MediaType.IMAGE, "New Image $i", 1 + random.nextInt(10), "${size}MB"));
              break;
            case MediaType.VIDEO:
              final size = (0.01 + random.nextDouble() * (10.0 - 0.01)).toStringAsFixed(1);
              items.value.add(MediaModel(MediaType.VIDEO, "New Video $i", 1 + random.nextInt(10), "${size}MB"));
              break;
          }
        }
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        generateItems(10);
      });
      return null;
    }, []);

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      itemCount: items.value.length,
      itemBuilder: (context, index) {
        return MediaItemAdd(item: items.value[index], onFolderTap: onFolderTap);
      },
    );
  }
}
