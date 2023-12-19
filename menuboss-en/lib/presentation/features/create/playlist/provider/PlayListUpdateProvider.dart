import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/RequestPlaylistUpdateInfoModel.dart';
import 'package:menuboss/domain/usecases/remote/playlist/PatchPlaylistUseCase.dart';
import 'package:menuboss_common/utils/UiState.dart';

final playListUpdateProvider = StateNotifierProvider<PlayListUpdateNotifier, UIState<String?>>(
  (ref) => PlayListUpdateNotifier(),
);

class PlayListUpdateNotifier extends StateNotifier<UIState<String?>> {
  PlayListUpdateNotifier() : super(Idle());

  final PatchPlaylistUseCase _patchPlaylistUseCase = GetIt.instance<PatchPlaylistUseCase>();

  void updatePlaylist(int playlistId, RequestPlaylistUpdateInfoModel model){
    state = Loading();

    _patchPlaylistUseCase.call(playlistId, model).then((response) async {
      if (response.status == 200) {
        state = Success(response.message);
      } else {
        state = Failure(response.message);
      }
    });
  }

  void init() {
    state = Idle();
  }
}
