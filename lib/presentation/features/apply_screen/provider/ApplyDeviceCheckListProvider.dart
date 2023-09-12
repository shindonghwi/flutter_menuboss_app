import 'package:hooks_riverpod/hooks_riverpod.dart';

final ApplyScreenCheckListProvider = StateNotifierProvider<ApplyDeviceCheckListNotifier, List<int>>(
  (ref) => ApplyDeviceCheckListNotifier(),
);

class ApplyDeviceCheckListNotifier extends StateNotifier<List<int>> {
  ApplyDeviceCheckListNotifier() : super([]);

  void onChanged(int index){
    if (isExist(index)) {
      state = [...state]..remove(index);
    } else {
      state = [...state, index];
    }
  }

  bool isExist(int index){
    return state.contains(index);
  }

  void clear(){
    state = [];
  }
}
