import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';
import 'package:menuboss/domain/usecases/remote/playlist/GetPlaylistsUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final PlayListProvider = StateNotifierProvider<PlayListNotifier, UIState<List<ResponsePlaylistModel>>>(
  (ref) => PlayListNotifier(),
);

class PlayListNotifier extends StateNotifier<UIState<List<ResponsePlaylistModel>>> {
  PlayListNotifier() : super(Idle());

  final GetPlaylistsUseCase _getPlaylistsUseCase = GetIt.instance<GetPlaylistsUseCase>();

  void requestGetPlaylists() {
    state = Loading();
    _getPlaylistsUseCase.call().then((response) {
      if (response.status == 200) {
        state = Success(response.list?.map((e) => e.toUpDatedAtSimpleMapper()).toList() ?? []);
      } else {
        state = Failure(response.message);
      }
    });
  }

  void init() {
    state = Idle();
  }
}
