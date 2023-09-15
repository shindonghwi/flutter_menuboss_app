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
    switch(item.type?.toLowerCase()){
      case "folder":
        _getMediaUseCase.call(item.id.toString()).then((response) {
          if (response.status == 200) {
            // response.data
            // state = [...state, ...response.data?.toList() ?? []];
          }
        });
      default:
        state = [...state, item];
    }
  }

  void removeItem(SimpleMediaContentModel item) {
    state = [...state]..remove(item);
  }

  void changeDurationItem(SimpleMediaContentModel item, int duration) {
    state = [
      ...state.map((e) {
        return e == item ? item.copyWith(duration: duration) : e;
      }).toList()
    ];
  }

  void init(){
    state = [];
  }
}
