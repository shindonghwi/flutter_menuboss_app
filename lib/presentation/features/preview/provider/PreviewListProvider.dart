import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/SimpleMediaContentModel.dart';

class PreviewModel {
  final String? direction;
  final String? fill;
  final List<SimpleMediaContentModel> previewItems;
  final List<int?> durations;

  PreviewModel(
    this.direction,
    this.fill,
    this.previewItems,
    this.durations,
  );
}

final previewListProvider = StateNotifierProvider<PreviewListProviderNotifier, PreviewModel?>(
  (ref) => PreviewListProviderNotifier(),
);

class PreviewListProviderNotifier extends StateNotifier<PreviewModel?> {
  PreviewListProviderNotifier() : super(null);

  void changeItems(PreviewModel item) => state = item;

  void clear() => state = null;

  void init() => state = null;
}
