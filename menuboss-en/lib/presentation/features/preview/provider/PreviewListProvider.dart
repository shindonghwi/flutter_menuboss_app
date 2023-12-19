import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/SimpleMediaContentModel.dart';

import '../../create/playlist/provider/PlaylistSaveInfoProvider.dart';

class PreviewModel {
  final PlaylistSettingType direction;
  final PlaylistSettingType fill;
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
