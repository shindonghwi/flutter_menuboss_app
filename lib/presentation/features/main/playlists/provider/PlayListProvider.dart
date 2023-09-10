import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/features/main/playlists/model/PlayListModel.dart';
import 'package:menuboss/presentation/features/main/playlists/widget/PlayListItem.dart';

final playListProvider =
    StateNotifierProvider.family<PlayListNotifier, List<PlayListModel>, GlobalKey<AnimatedListState>>(
  (ref, listKey) => PlayListNotifier(listKey: listKey),
);

class PlayListNotifier extends StateNotifier<List<PlayListModel>> {
  PlayListNotifier({required this.listKey}) : super([]);

  final GlobalKey<AnimatedListState> listKey;

  void addItem(PlayListModel item) {
    listKey.currentState?.insertItem(0, duration: const Duration(milliseconds: 300));
    state = [item, ...state];
  }

  void removeItem(PlayListModel item) {
    final index = state.indexOf(item);
    if (index != -1) {
      listKey.currentState?.removeItem(index, (context, animation) {
        return _animatedItemBuilder(item, animation);
      }, duration: const Duration(milliseconds: 300));
      state = [...state]..remove(item);
    }
  }

  Widget _animatedItemBuilder(PlayListModel item, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-0.6, 0),
        end: Offset.zero,
      ).animate(animation),
      child: FadeTransition(
        opacity: animation,
        child: PlayListItem(
            item: item, listKey: listKey), // Assuming this method returns the visual representation of the item.
      ),
    );
  }
}
