import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/data/models/media/ResponseMediaProperty.dart';
import 'package:menuboss/data/models/media/ResponseMediaPropertyInfo.dart';
import 'package:menuboss/domain/usecases/local/app/PostMediaFilterTypeUseCase.dart';
import 'package:menuboss/domain/usecases/remote/media/DelMediaUseCase.dart';
import 'package:menuboss/domain/usecases/remote/media/GetMediasUseCase.dart';
import 'package:menuboss/domain/usecases/remote/media/PatchMediaNameUseCase.dart';
import 'package:menuboss/domain/usecases/remote/media/PostCreateMediaFolderUseCase.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetFilterSelector.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final MediaListProvider = StateNotifierProvider<MediaListNotifier, UIState<List<ResponseMediaModel>>>(
  (ref) => MediaListNotifier(),
);

class MediaListNotifier extends StateNotifier<UIState<List<ResponseMediaModel>>> {
  MediaListNotifier() : super(Idle());

  int _currentPage = 1;
  bool _hasNext = true;
  bool _isProcessing = false;
  List<ResponseMediaModel> _currentItems = [];
  FilterType _filterType = FilterType.NewestFirst;

  final GetMediasUseCase _getMediasUseCase = GetIt.instance<GetMediasUseCase>();
  final DelMediaUseCase _delMediaUseCase = GetIt.instance<DelMediaUseCase>();
  final PostCreateMediaFolderUseCase _createMediaFolderUseCase = GetIt.instance<PostCreateMediaFolderUseCase>();
  final PatchMediaNameUseCase _mediaNameUseCase = GetIt.instance<PatchMediaNameUseCase>();
  final PostMediaFilterTypeUseCase _filterTypeUseCase = GetIt.instance<PostMediaFilterTypeUseCase>();

  /// 미디어 리스트 요청
  Future<void> requestGetMedias({int? delayed}) async {
    if (_currentPage == 1) {
      state = Loading();
    }

    await Future.delayed(Duration(milliseconds: delayed ?? 0));

    if (_hasNext) {
      if (_isProcessing) return;
      _isProcessing = true;
      _getMediasUseCase.call(page: _currentPage, size: 50, sort: filterParams[_filterType]!).then((response) {
        try {
          if (response.status == 200) {
            final responseItems = response.list?.toList() ?? [];
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
            state = Failure(response.message);
          }
        } catch (e) {
          state = Failure(response.message);
        }
        _isProcessing = false;
      });
    }else{
      init();
    }
  }

  /// 미디어 폴더 생성
  void createFolder() {
    state = Loading();
    _createMediaFolderUseCase.call().then((response) {
      if (response.status == 200) {
        initPageInfo();
        final item = response.data;

        DateTime now = DateTime.now();
        String formattedDate = DateFormat('MMM dd, y, hh:mm a').format(now);

        final newFolder = ResponseMediaModel(
          object: item?.object ?? "",
          mediaId: item?.mediaId ?? "",
          name: item?.name ?? "",
          type: ResponseMediaPropertyInfo(
            code: 'folder',
            name: 'folder',
          ),
          property: ResponseMediaProperty(
            count: 0,
            size: 0,
          ),
          createdAt: formattedDate,
          updatedAt: formattedDate,
        );

        List<ResponseMediaModel> updateItems = [newFolder, ..._currentItems];
        updateCurrentItems(updateItems);
        state = Success(updateItems);
      } else {
        state = Failure(response.message);
      }
    });
  }

  /// 미디어 이름 변경
  void renameItem(String mediaId, String newName) async {
    state = Loading();
    _mediaNameUseCase.call(mediaId, newName).then((response) {
      if (response.status == 200) {
        final updatedItems = _currentItems.map((item) {
          if (item.mediaId == mediaId) {
            return item.copyWith(name: newName, createdAt: item.createdAt, updatedAt: item.updatedAt);
          }
          return item;
        }).toList();
        List<ResponseMediaModel> updateItems = [...updatedItems];
        updateCurrentItems(updateItems);
        state = Success(updateItems);
      } else {
        state = Failure(response.message);
      }
    });
  }

  /// 미디어 삭제
  void removeItem(List<String> mediaIds) {
    state = Loading();
    _delMediaUseCase.call(mediaIds).then((response) {
      if (response.status == 200) {
        List<ResponseMediaModel> updateItems = _currentItems.where((item) => !mediaIds.contains(item.mediaId)).toList();
        updateCurrentItems(updateItems);
        state = Success(updateItems);
      } else {
        state = Failure(response.message);
      }
    });
  }

  /// 미디어 정렬 순서 변경
  void changeFilterType(FilterType type) async {
    await _filterTypeUseCase.call(type);
    _filterType = type;
    initPageInfo();
    requestGetMedias(delayed: 600);
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
