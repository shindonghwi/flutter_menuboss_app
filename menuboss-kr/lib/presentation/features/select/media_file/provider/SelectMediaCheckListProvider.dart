import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectMediaCheckListProvider = StateNotifierProvider<SelectMediaCheckListProviderNotifier, List<String>>(
      (ref) => SelectMediaCheckListProviderNotifier(),
);

class SelectMediaCheckListProviderNotifier extends StateNotifier<List<String>> {
  SelectMediaCheckListProviderNotifier() : super([]);

  void onChanged(String mediaId){
    if (isExist(mediaId)) {
      state = [...state]..remove(mediaId);
    } else {
      state = [...state, mediaId];
    }
  }

  bool isExist(String mediaId){
    return state.contains(mediaId);
  }

  void init(){
    state = [];
  }
}
