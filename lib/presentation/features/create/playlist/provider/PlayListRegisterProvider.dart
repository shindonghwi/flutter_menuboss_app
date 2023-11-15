import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/RequestPlaylistUpdateInfoModel.dart';
import 'package:menuboss/domain/usecases/remote/playlist/PostPlaylistUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final playListRegisterProvider = StateNotifierProvider<PlayListRegisterNotifier, UIState<String?>>(
  (ref) => PlayListRegisterNotifier(),
);

class PlayListRegisterNotifier extends StateNotifier<UIState<String?>> {
  PlayListRegisterNotifier() : super(Idle());

  final PostPlaylistUseCase _postPlaylistUseCase = GetIt.instance<PostPlaylistUseCase>();

  void registerPlaylist(RequestPlaylistUpdateInfoModel model) {
    state = Loading();
    _postPlaylistUseCase.call(model).then((response) async {
      if (response.status == 200) {
        state = Success(response.data?.playlistId.toString());
      } else {
        state = Failure(response.message);
      }
    });
  }

  void init(){
    state = Idle();
  }
}
