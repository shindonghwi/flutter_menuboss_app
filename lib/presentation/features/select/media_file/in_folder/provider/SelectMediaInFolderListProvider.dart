import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/domain/usecases/local/app/PostMediaFilterTypeUseCase.dart';
import 'package:menuboss/domain/usecases/remote/media/DelMediaUseCase.dart';
import 'package:menuboss/domain/usecases/remote/media/GetMediasUseCase.dart';
import 'package:menuboss/domain/usecases/remote/media/PatchMediaNameUseCase.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetFilterSelector.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final SelectMediaInFolderListProvider = StateNotifierProvider<SelectMediaInFolderListNotifier, UIState<List<ResponseMediaModel>>>(
  (ref) => SelectMediaInFolderListNotifier(),
);

class SelectMediaInFolderListNotifier extends StateNotifier<UIState<List<ResponseMediaModel>>> {
  SelectMediaInFolderListNotifier() : super(Idle());

  int _currentPage = 1;
  bool _hasNext = true;
  bool _isProcessing = false;
  List<ResponseMediaModel> _currentItems = [];
  FilterType _filterType = FilterType.NewestFirst;

  final GetMediasUseCase _getMediasUseCase = GetIt.instance<GetMediasUseCase>();

  /// 미디어 리스트 요청
  Future<void> requestGetMedias({required String mediaId, int? delayed}) async {
    if (_currentPage == 1) {
      state = Loading();
    }

    await Future.delayed(Duration(milliseconds: delayed ?? 0));

    if (_hasNext) {
      if (_isProcessing) return;
      _isProcessing = true;
      _getMediasUseCase.call(page: _currentPage, size: 50, sort: filterParams[_filterType]!, mediaId: mediaId).then((response) {
        try {
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
          state = Failure(response.message);
        }
        _isProcessing = false;
      });
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
