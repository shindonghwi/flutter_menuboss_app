import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistsModel.dart';
import 'package:menuboss/domain/usecases/remote/playlist/GetPlaylistsUseCase.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/UiState.dart';

final getSelectPlaylistProvider =
    StateNotifierProvider<GetSelectPlaylistProviderNotifier, UIState<List<ResponsePlaylistsModel>>>(
  (ref) => GetSelectPlaylistProviderNotifier(),
);

class GetSelectPlaylistProviderNotifier extends StateNotifier<UIState<List<ResponsePlaylistsModel>>> {
  GetSelectPlaylistProviderNotifier() : super(Idle());

  GetPlaylistsUseCase get _playListsUseCase => GetIt.instance<GetPlaylistsUseCase>();

  final List<int> addedPlaylistIds = [];

  void requestPlaylists() async {
    state = Loading();

    _playListsUseCase.call().then((response) async {
      if (response.status == 200) {
        List<ResponsePlaylistsModel> filteredList =
            response.list?.map((e) => e.toUpDatedAtSimpleMapper()).toList() ?? [];
        state = Success(filteredList);
      } else {
        state = Failure(response.message);
      }
    });
  }

  void init(List<int>? playlistIds) {
    state = Idle();
    addedPlaylistIds.clear();
    if (!CollectionUtil.isNullorEmpty(playlistIds)) {
      addedPlaylistIds.addAll(playlistIds!);
    }
  }
}
