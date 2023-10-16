import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/SimpleMediaContentModel.dart';
import 'package:menuboss/domain/usecases/remote/media/GetMediaUseCase.dart';

final mediaContentsCartProvider = StateNotifierProvider<MediaContentsCartNotifier, List<SimpleMediaContentModel>>(
  (ref) => MediaContentsCartNotifier(),
);

class MediaContentsCartNotifier extends StateNotifier<List<SimpleMediaContentModel>> {
  MediaContentsCartNotifier() : super([]);

  void addItem(SimpleMediaContentModel item) {
    state = [...state, item];
  }

  void addItems(List<SimpleMediaContentModel> items) {
    var uniqueItems = items.where((item) => !state.any((existingItem) => existingItem.id == item.id)).toList();
    state = [...state, ...uniqueItems];
  }

  void removeItem(int index) {
    state = [...state..removeAt(index)];
  }

  void changeDurationItem(SimpleMediaContentModel item, double duration) {
    state = [
      ...state.map((e) {
        return e == item ? item.copyWith(property: item.property?.copyWith(duration: duration)) : e;
      }).toList()
    ];
  }

  void init() {
    state = [];
  }
}
