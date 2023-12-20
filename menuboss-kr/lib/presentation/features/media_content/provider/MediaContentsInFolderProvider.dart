import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/data/models/media/SimpleMediaContentModel.dart';
import 'package:menuboss/domain/usecases/remote/media/GetMediasUseCase.dart';
import 'package:menuboss_common/components/bottom_sheet/BottomSheetFilterSelector.dart';
import 'package:menuboss_common/utils/UiState.dart';
import 'package:menuboss_common/utils/UiState.dart';

final mediaContentsInFolderProvider =
    StateNotifierProvider<MediaContentsInFolderNotifier, UIState<List<SimpleMediaContentModel>>>(
  (ref) => MediaContentsInFolderNotifier(),
);

class MediaContentsInFolderNotifier extends StateNotifier<UIState<List<SimpleMediaContentModel>>> {
  MediaContentsInFolderNotifier() : super(Idle());

  int _currentPage = 1;
  bool _hasNext = true;
  bool _isProcessing = false;
  List<ResponseMediaModel> _originMediaItems = [];

  Map<FilterType, String> filterKeys = {};

  void updateFilterKeys(Map<FilterType, String> filterKeys) => this.filterKeys = filterKeys;

  final GetMediasUseCase _getMediasUseCase = GetIt.instance<GetMediasUseCase>();

  /// 미디어 리스트 요청
  Future<void> requestGetMedias(String folderId, {int delay = 0}) async {
    if (_hasNext) {
      if (_currentPage == 1) {
        state = Loading();
      }

      await Future.delayed(Duration(milliseconds: delay));

      if (_isProcessing) return;
      _isProcessing = true;

      try {
        final response = await _getMediasUseCase.call(
            page: _currentPage, size: 20, mediaId: folderId, sort: filterKeys[FilterType.NewestFirst]!);
        if (response.status == 200) {
          final responseItems = response.list?.where((e) => e.type?.code.toLowerCase() != "folder").toList() ?? [];

          List<SimpleMediaContentModel> updateItems = [];
          if (_currentPage == 1) {
            updateItems = responseItems.map((e) => e.toMapperMediaContentModel()).toList();
          } else {
            updateItems = [
              ..._originMediaItems.map((e) => e.toMapperMediaContentModel()),
              ...responseItems.map((e) => e.toMapperMediaContentModel())
            ];
          }
          updateCurrentItems(responseItems);
          _hasNext = response.page!.hasNext;
          _currentPage = response.page!.currentPage + 1;
          state = Success([...updateItems]);
        } else {
          state = Failure(response.message);
        }
      } catch (e) {
        state = Failure(e.toString());
      }
      _isProcessing = false;
    }
  }

  void updateCurrentItems(List<ResponseMediaModel> items) {
    _originMediaItems = items;
  }

  void initPageInfo() {
    _currentPage = 1;
    _hasNext = true;
    _isProcessing = false;
  }

  void init() {
    state = Idle();
  }
}
