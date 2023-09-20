import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';
import 'package:menuboss/domain/usecases/remote/playlist/GetPlaylistsUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';

final GetSelectPlaylistProvider =
    StateNotifierProvider<GetSelectPlaylistProviderNotifier, UIState<List<ResponsePlaylistModel>>>(
  (ref) => GetSelectPlaylistProviderNotifier(),
);

class GetSelectPlaylistProviderNotifier extends StateNotifier<UIState<List<ResponsePlaylistModel>>> {
  GetSelectPlaylistProviderNotifier() : super(Idle());

  GetPlaylistsUseCase get _playListsUseCase => GetIt.instance<GetPlaylistsUseCase>();

  final List<int> addedPlaylistIds = [];

  void requestPlaylists() {
    state = Loading();
    _playListsUseCase.call().then((response) async {
      if (response.status == 200) {
        List<ResponsePlaylistModel> filteredList = response.list
                ?.where((e) => !addedPlaylistIds.contains(e.playlistId))
                .map((e) => e.toUpDatedAtSimpleMapper())
                .toList() ??
            [];
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
