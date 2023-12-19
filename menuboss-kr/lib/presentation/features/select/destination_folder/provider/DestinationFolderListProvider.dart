import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:menuboss/data/models/media/ResponseMediaCreate.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/data/models/media/ResponseMediaProperty.dart';
import 'package:menuboss/data/models/media/ResponseMediaPropertyInfo.dart';
import 'package:menuboss/domain/usecases/remote/media/GetMediasUseCase.dart';
import 'package:menuboss/domain/usecases/remote/media/PostCreateMediaFolderUseCase.dart';
import 'package:menuboss_common/components/bottom_sheet/BottomSheetFilterSelector.dart';
import 'package:menuboss_common/utils/UiState.dart';

final DestinationFolderListProvider =
    StateNotifierProvider<DestinationFolderListNotifier, UIState<List<ResponseMediaModel?>>>(
  (ref) => DestinationFolderListNotifier(),
);

class DestinationFolderListNotifier extends StateNotifier<UIState<List<ResponseMediaModel>>> {
  DestinationFolderListNotifier() : super(Idle());

  int _currentPage = 1;
  List<ResponseMediaModel> _currentItems = [];
  final FilterType _filterType = FilterType.NewestFirst;

  final GetMediasUseCase _getMediasUseCase = GetIt.instance<GetMediasUseCase>();
  final PostCreateMediaFolderUseCase _createMediaFolderUseCase = GetIt.instance<PostCreateMediaFolderUseCase>();

  Future<void> requestGetFolders({
    required String rootFolderName,
    required Map<FilterType, String> filterKeys,
  }) async {
    updateCurrentItems([]);
    state = Loading();

    Future<void> fetchPages() async {
      final response = await _getMediasUseCase.call(page: _currentPage, size: 50, sort: filterKeys[_filterType]!);

      try {
        if (response.status == 200) {
          final responseItems = response.list ?? [];
          if (responseItems.isEmpty) {
            _currentItems.insert(0, ResponseMediaModel(name: rootFolderName));
            state = Success([..._currentItems]); // null은 루트폴더
            return;
          }
          final lastItemIsFolder = responseItems.last.type?.code.toLowerCase() == "folder";
          final folderItems = responseItems.where((element) => element.type?.code.toLowerCase() == "folder").toList();
          updateCurrentItems([..._currentItems, ...folderItems]);

          if (lastItemIsFolder) {
            _currentPage = response.page!.currentPage + 1;
            await fetchPages();
          } else {
            if (!_currentItems.any((item) => item.name == rootFolderName)) {
              _currentItems.insert(0, ResponseMediaModel(name: rootFolderName));
            }
            state = Success([..._currentItems]); // null은 루트폴더
          }
        } else {
          state = Failure(response.message);
        }
      } catch (e) {
        state = Failure(response.message);
      }
    }

    await fetchPages();
  }

  Future<ResponseMediaModel?> createFolder() async {
    final response = await _createMediaFolderUseCase.call();

    if (response.status == 200) {
      final item = response.data;
      final newFolder = generateNewFolder(item);

      if (_currentItems.isEmpty || (_currentItems.isNotEmpty && _currentItems[0].name != "Media")) {
        _currentItems.insert(0, ResponseMediaModel(name: "Media"));
      }
      _currentItems.insert(1, newFolder);

      state = Success([..._currentItems]);
      return newFolder;
    } else {
      state = Failure(response.message);
      return null;
    }
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

  void updateCurrentItems(List<ResponseMediaModel> items) {
    _currentItems = items;
  }

  void init() {
    state = Idle();
  }
}
