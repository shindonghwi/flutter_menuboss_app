import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetFilterSelector.dart';
import 'package:menuboss/presentation/features/main/media/model/MediaModel.dart';
import 'package:menuboss/presentation/features/main/media/model/MediaType.dart';

import '../widget/MediaFolder.dart';
import '../widget/MediaImage.dart';
import '../widget/MediaVideo.dart';

final mediaListProvider = StateNotifierProvider<MediaListNotifier, List<MediaModel>>(
      (ref) => MediaListNotifier(),
);

class MediaListNotifier extends StateNotifier<List<MediaModel>> {
  MediaListNotifier() : super([]);

  void addItem(MediaModel item, {GlobalKey<AnimatedListState>? listKey}) {
    listKey?.currentState?.insertItem(0, duration: const Duration(milliseconds: 300));
    state = [item, ...state];
  }

  void removeItem(MediaModel item, GlobalKey<AnimatedListState>? listKey) {
    final index = state.indexOf(item);
    if (index != -1) {
      listKey?.currentState?.removeItem(index, (context, animation) {
        return _animatedItemBuilder(item, animation, listKey);
      }, duration: const Duration(milliseconds: 300));
      Future.delayed(const Duration(milliseconds: 300), () {
        state = [...state]..remove(item);
      });
    }
  }

  void sortByName(FilterType type) {
    state.sort((a, b) {
      if (a.type == MediaType.FOLDER && b.type != MediaType.FOLDER) return -1;
      if (a.type != MediaType.FOLDER && b.type == MediaType.FOLDER) return 1;

      if (type == FilterType.NameAsc) {
        return a.fileName.compareTo(b.fileName);
      } else {
        return b.fileName.compareTo(a.fileName);
      }
    });
    state = [...state];
  }

  Widget _animatedItemBuilder(MediaModel item, Animation<double> animation, GlobalKey<AnimatedListState> listKey) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-0.6, 0),
        end: Offset.zero,
      ).animate(animation),
      child: FadeTransition(
        opacity: animation,
        child: _buildListItem(item, listKey),
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
