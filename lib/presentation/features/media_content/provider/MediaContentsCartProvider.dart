import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/SimpleMediaContentModel.dart';
import 'package:menuboss/domain/usecases/remote/media/GetMediaUseCase.dart';

final MediaContentsCartProvider = StateNotifierProvider<MediaContentsCartNotifier, List<SimpleMediaContentModel>>(
  (ref) => MediaContentsCartNotifier(),
);

class MediaContentsCartNotifier extends StateNotifier<List<SimpleMediaContentModel>> {
  MediaContentsCartNotifier() : super([]);

  final GetMediaUseCase _getMediaUseCase = GetIt.instance<GetMediaUseCase>();

  void addItem(SimpleMediaContentModel item) {
    if (!state.any((existingItem) => existingItem.id == item.id)) {
      switch (item.type?.toLowerCase()) {
        case "folder":
          _getMediaUseCase.call(item.id.toString()).then((response) {
            if (response.status == 200) {
              // response.data
              // state = [...state, ...response.data?.toList() ?? []];
            }
          });
          break;
        default:
          state = [...state, item];
      }
    }
  }

  void addItems(List<SimpleMediaContentModel> items) {
    var uniqueItems = items.where((item) => !state.any((existingItem) => existingItem.id == item.id)).toList();
    state = [...state, ...uniqueItems];
  }

  void removeItem(SimpleMediaContentModel item) {
    state = [...state.where((existingItem) => existingItem.id != item.id)];
  }

  void changeDurationItem(SimpleMediaContentModel item, int duration) {
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
