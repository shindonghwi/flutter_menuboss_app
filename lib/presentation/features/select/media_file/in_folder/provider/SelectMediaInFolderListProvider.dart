import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/domain/usecases/remote/media/GetMediasUseCase.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetFilterSelector.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final selectMediaInFolderListProvider =
    StateNotifierProvider<SelectMediaInFolderListNotifier, UIState<List<ResponseMediaModel>>>(
  (ref) => SelectMediaInFolderListNotifier(),
);

class SelectMediaInFolderListNotifier extends StateNotifier<UIState<List<ResponseMediaModel>>> {
  SelectMediaInFolderListNotifier() : super(Idle());

  int _currentPage = 1;
  bool _hasNext = true;
  bool _isProcessing = false;
  List<ResponseMediaModel> _currentItems = [];
  final FilterType _filterType = FilterType.NewestFirst;

  final GetMediasUseCase _getMediasUseCase = GetIt.instance<GetMediasUseCase>();

  /// 미디어 리스트 요청
  Future<void> requestGetMedias({
    required Map<FilterType, String> filterKeys,
    required String mediaId,
    int? delayed,
  }) async {
    if (_hasNext) {
      if (_currentPage == 1) {
        state = Loading();
      }

      if (_isProcessing) return;
      _isProcessing = true;

      await Future.delayed(Duration(milliseconds: delayed ?? 0));

      try {
        final response = await _getMediasUseCase.call(
            page: _currentPage, size: 50, sort: filterKeys[_filterType]!, mediaId: mediaId);
        if (response.status == 200) {
          final responseItems = response.list?.where((e) => e.type?.code.toLowerCase() != "folder").toList() ?? [];
          List<ResponseMediaModel> updateItems = [];
          if (_currentPage == 1) {
            updateItems = responseItems;
          } else {
            updateItems = [..._currentItems, ...responseItems];
          }
          updateCurrentItems(updateItems);
          _hasNext = response.page!.hasNext;
          _currentPage = response.page!.currentPage + 1;
          state = Success([...updateItems]);
        } else {
          initPageInfo();
          state = Failure(response.message);
        }
      } catch (e) {
        initPageInfo();
        state = Failure(e.toString());
      }

      _isProcessing = false;
    }
  }

  void updateCurrentItems(List<ResponseMediaModel> items) {
    _currentItems = items;
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
