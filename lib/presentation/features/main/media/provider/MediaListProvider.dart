import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetFilterSelector.dart';
import 'package:menuboss/presentation/features/main/media/model/MediaItem.dart';
import 'package:menuboss/presentation/features/main/media/model/MediaType.dart';

import '../widget/MediaFolder.dart';
import '../widget/MediaImage.dart';
import '../widget/MediaVideo.dart';

final mediaListProvider =
    StateNotifierProvider.family<MediaListNotifier, List<MediaItem>, GlobalKey<AnimatedListState>>(
  (ref, listKey) => MediaListNotifier(listKey: listKey),
);

class MediaListNotifier extends StateNotifier<List<MediaItem>> {
  MediaListNotifier({required this.listKey}) : super([]);

  final GlobalKey<AnimatedListState> listKey;

  void addItem(MediaItem item) {
    listKey.currentState?.insertItem(0, duration: const Duration(milliseconds: 300));
    state = [item, ...state];
  }

  void removeItem(MediaItem item) {
    final index = state.indexOf(item);
    if (index != -1) {
      listKey.currentState?.removeItem(index, (context, animation) {
        return _animatedItemBuilder(item, animation);
      }, duration: const Duration(milliseconds: 300));
      state = [...state]..remove(item);
    }
  }

  // 사용자가 정의한 필터로 정렬
  void sortByName(List<MediaItem> items, FilterType type) {
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
    state = [...items];
  }

  /// @feature: media 아이템 빌더 ( media screen ) 내용과 겹침.
  /// @author: 2023/09/08 1:02 PM donghwishin
  /// @param: [MediaItem] item, [Animation<double>] animation
  /// @return: [Widget] _animatedItemBuilder
  /// @description: 아이템 삭제시 애니메이션 효과를 위한 메소드

  Widget _animatedItemBuilder(MediaItem item, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-0.6, 0),
        end: Offset.zero,
      ).animate(animation),
      child: FadeTransition(
        opacity: animation,
        child: _buildListItem(item, listKey), // Assuming this method returns the visual representation of the item.
      ),
    );
  }

  Widget _buildListItem(MediaItem item, GlobalKey<AnimatedListState> listKey) {
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
