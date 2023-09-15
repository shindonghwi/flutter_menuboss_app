import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/SimpleMediaContentModel.dart';

final MediaContentsCartProvider = StateNotifierProvider<MediaContentsCartNotifier, List<SimpleMediaContentModel>>(
  (ref) => MediaContentsCartNotifier(),
);

class MediaContentsCartNotifier extends StateNotifier<List<SimpleMediaContentModel>> {
  MediaContentsCartNotifier() : super([]);

  void addItem(SimpleMediaContentModel item) {
    state = [...state, item];
  }

  void removeItem(SimpleMediaContentModel item) {
    state = [...state]..remove(item);
  }

  void changeDurationItem(String id, int duration) {
    state = [
      ...state.map((item) {
        return item.id == id ? item.copyWith(duration: duration) : item;
      }).toList()
    ];
  }
}
