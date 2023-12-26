import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:menuboss/data/models/media/ResponseMediaCreate.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/data/models/media/ResponseMediaProperty.dart';
import 'package:menuboss/data/models/media/ResponseMediaPropertyInfo.dart';
import 'package:menuboss/domain/usecases/local/app/PostMediaFilterTypeUseCase.dart';
import 'package:menuboss/domain/usecases/remote/media/DelMediaUseCase.dart';
import 'package:menuboss/domain/usecases/remote/media/GetMediasUseCase.dart';
import 'package:menuboss/domain/usecases/remote/media/PatchMediaNameUseCase.dart';
import 'package:menuboss/domain/usecases/remote/media/PostCreateMediaFolderUseCase.dart';
import 'package:menuboss_common/components/bottom_sheet/BottomSheetFilterSelector.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/UiState.dart';

final mediaListProvider = StateNotifierProvider<MediaListNotifier, UIState<List<ResponseMediaModel>>>(
      (ref) => MediaListNotifier(),
);

class MediaListNotifier extends StateNotifier<UIState<List<ResponseMediaModel>>> {
  MediaListNotifier() : super(Idle());

  int _currentPage = 1;
  bool _hasNext = true;
  bool _isProcessing = false;
  List<ResponseMediaModel> currentItems = [];
  FilterType _filterType = FilterType.NewestFirst;

  final GetMediasUseCase _getMediasUseCase = GetIt.instance<GetMediasUseCase>();
  final DelMediaUseCase _delMediaUseCase = GetIt.instance<DelMediaUseCase>();
  final PostCreateMediaFolderUseCase _createMediaFolderUseCase = GetIt.instance<PostCreateMediaFolderUseCase>();
  final PatchMediaNameUseCase _mediaNameUseCase = GetIt.instance<PatchMediaNameUseCase>();
  final PostMediaFilterTypeUseCase _saveFilterTypeUseCase = GetIt.instance<PostMediaFilterTypeUseCase>();

  Map<FilterType, String> filterKeys = {};

  void updateFilterKeys(Map<FilterType, String> filterKeys) => this.filterKeys = filterKeys;

  /// 미디어 리스트 요청
  Future<List<dynamic>> requestGetMedias({int? delayed}) async {
    if (_hasNext) {
      if (_currentPage == 1) {
        state = Loading();
      }

      await Future.delayed(Duration(milliseconds: delayed ?? 0));

      if (!_isProcessing) {
        _isProcessing = true;
        try {
          final response = await _getMediasUseCase.call(page: _currentPage, size: 30, sort: filterKeys[_filterType]!);

          if (response.status == 200) {
            final responseItems = response.list?.toList() ?? [];
            List<ResponseMediaModel> updateItems = [];

            if (_currentPage == 1) {
              updateItems = responseItems;
            } else {
              updateItems = [...currentItems, ...responseItems];
            }

            updateCurrentItems(updateItems);
            _hasNext = response.page!.hasNext;
            _currentPage = response.page!.currentPage + 1;
            state = Success([...updateItems]);
            return updateItems;
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
    return [];
  }

  /// 미디어 폴더 생성
  void createFolder() {
    state = Loading();
    _createMediaFolderUseCase.call().then((response) {
      if (response.status == 200) {
        initPageInfo();
        final item = response.data;
        final newFolder = generateNewFolder(item);

        List<ResponseMediaModel> updateItems = [newFolder, ...currentItems];
        updateCurrentItems(updateItems);
        state = Success(updateItems);
      } else {
        state = Failure(response.message);
      }
    });
  }

  ResponseMediaModel generateNewFolder(ResponseMediaCreate? item) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMM dd, y, hh:mm a').format(now);

    return ResponseMediaModel(
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
  }

  /// 미디어 이름 변경
  void renameItem(String mediaId, String newName) async {
    _mediaNameUseCase.call(mediaId, newName).then((response) {
      if (response.status == 200) {
        final updatedItems = currentItems.map((item) {
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
  Future<bool> removeItem(List<String> mediaIds, {String? folderId}) {
    return _delMediaUseCase.call(mediaIds).then((response) async {
      if (response.status == 200) {
        List<ResponseMediaModel> updateItems = currentItems.where((item) => !mediaIds.contains(item.mediaId)).toList();
        updateCurrentItems(updateItems, isUiUpdate: true);
        return Future(() => true);
      } else {
        state = Failure(response.message);
        return Future(() => false);
      }
    });
  }

  /// 업데이트 folder count and size
  List<ResponseMediaModel> updateFolderCountAndSize(String folderId, int sizeChange,
      {bool isIncrement = false, bool isUiUpdate = false}) {
    debugPrint("updateFolderCountAndSize: $folderId");
    ResponseMediaModel? folderItem = currentItems.firstWhere((item) => item.mediaId == folderId);

    if ((folderItem.property?.count ?? 0) > 0) {
      int updatedCount = folderItem.property!.count! + (isIncrement ? 1 : -1);
      int updatedSize = folderItem.property!.size ?? 0;

      updatedSize = isIncrement ? updatedSize + sizeChange : updatedSize - sizeChange;

      if (updatedCount >= 0 && updatedSize >= 0) {
        int index = currentItems.indexOf(folderItem);
        currentItems[index] =
            folderItem.copyWith(property: folderItem.property?.copyWith(count: updatedCount, size: updatedSize));
      }

      if (isUiUpdate) {
        state = Success([...currentItems]);
      }
    }

    return currentItems;
  }

  /// 업데이트 카운트, 사이즈 일괄 변경 folder count and size
  List<ResponseMediaModel> updateLumpFolderCountAndSize(String folderId, int count, int size,
      {bool isUiUpdate = false}) {
    debugPrint("updateFolderCountAndSize: $folderId");
    ResponseMediaModel? folderItem = currentItems.firstWhere((item) => item.mediaId == folderId);

    int index = currentItems.indexOf(folderItem);
    currentItems[index] = folderItem.copyWith(
      property: folderItem.property?.copyWith(
        count: count,
        size: size,
      ),
    );

    if (isUiUpdate) {
      state = Success([...currentItems]);
    }

    return currentItems;
  }

  /// 미디어 정렬 순서 변경
  void changeFilterType(
      FilterType type, {
        required Map<FilterType, String> filterValue,
      }) async {
    await _saveFilterTypeUseCase.call(type, filterValue);
    _filterType = type;
    initPageInfo();
    requestGetMedias(delayed: 600);
  }

  void updateCurrentItems(List<ResponseMediaModel> items, {bool isUiUpdate = false}) {
    currentItems = items;
    if (isUiUpdate) {
      state = Success([...currentItems]);
    }
  }

  String getFolderName(String rootFolderName, String? folderId) {
    debugPrint("getFolderName: $folderId ${folderId == null}");
    if (CollectionUtil.isNullEmptyFromString(folderId)) {
      return rootFolderName; // root로 이동함.
    } else {
      ResponseMediaModel? folderItem = currentItems.firstWhere((item) => item.mediaId == folderId);
      return folderItem.name ?? "";
    }
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
