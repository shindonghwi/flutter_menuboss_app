import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';
import 'package:menuboss/domain/usecases/remote/playlist/GetPlaylistUseCase.dart';
import 'package:menuboss_common/utils/UiState.dart';

final getPlaylistProvider = StateNotifierProvider<GetPlaylistNotifier, UIState<ResponsePlaylistModel>>(
  (ref) => GetPlaylistNotifier(),
);

class GetPlaylistNotifier extends StateNotifier<UIState<ResponsePlaylistModel>> {
  GetPlaylistNotifier() : super(Idle());

  GetPlaylistUseCase get _getPlaylistUseCase => GetIt.instance<GetPlaylistUseCase>();

  void requestPlaylistInfo(int playlistId) {
    state = Loading();
    _getPlaylistUseCase.call(playlistId).then((value) async{
      if (value.status == 200) {
        if (value.data != null) {
          state = Success(value.data!);
        } else {
          state = Failure(value.message);
        }
      } else {
        state = Failure(value.message);
      }
    });
  }

  void init() {
    state = Idle();
  }
}
