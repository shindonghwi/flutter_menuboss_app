import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/domain/usecases/remote/playlist/DelPlaylistUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final DelPlaylistProvider = StateNotifierProvider<DelPlaylistNotifier, UIState<String?>>(
  (ref) => DelPlaylistNotifier(),
);

class DelPlaylistNotifier extends StateNotifier<UIState<String?>> {
  DelPlaylistNotifier() : super(Idle());

  DelPlaylistUseCase get _delPlaylistUseCase => GetIt.instance<DelPlaylistUseCase>();

  void removePlaylist(int playlistId) {
    state = Loading();
    _delPlaylistUseCase.call(playlistId).then((value) {
      if (value.status == 200) {
        state = Success(value.message);
      } else {
        state = Failure(value.message);
      }
    }).then((value) => Future.delayed(const Duration(milliseconds: 300), () => init()));
  }

  void init() => state = Idle();
}
