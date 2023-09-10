import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/features/main/devices/model/DeviceListModel.dart';
import 'package:menuboss/presentation/features/main/devices/widget/DeviceItem.dart';

final deviceListProvider =
    StateNotifierProvider.family<DeviceListNotifier, List<DeviceListModel>, GlobalKey<AnimatedListState>>(
  (ref, listKey) => DeviceListNotifier(listKey: listKey),
);

class DeviceListNotifier extends StateNotifier<List<DeviceListModel>> {
  DeviceListNotifier({required this.listKey}) : super([]);

  final GlobalKey<AnimatedListState> listKey;

  void addItem(DeviceListModel item) {
    listKey.currentState?.insertItem(0, duration: const Duration(milliseconds: 300));
    state = [item, ...state];
  }

  void removeItem(DeviceListModel item) {
    final index = state.indexOf(item);
    if (index != -1) {
      listKey.currentState?.removeItem(index, (context, animation) {
        return _animatedItemBuilder(item, animation);
      }, duration: const Duration(milliseconds: 300));
      state = [...state]..remove(item);
    }
  }

  void renameItem(DeviceListModel oldItem, String newScreenName) {
    int index = state.indexOf(oldItem);
    if (index != -1) {
      DeviceListModel updatedItem = oldItem.copyWith(screenName: newScreenName);
      state = [
        ...state.sublist(0, index),
        updatedItem,
        ...state.sublist(index + 1),
      ];
    }
  }

  Widget _animatedItemBuilder(DeviceListModel item, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-0.6, 0),
        end: Offset.zero,
      ).animate(animation),
      child: FadeTransition(
        opacity: animation,
        child: DeviceItem(
            item: item, listKey: listKey),
      ),
    );
  }
}
