import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';
import 'package:menuboss/domain/usecases/remote/playlist/DelPlaylistUseCase.dart';
import 'package:menuboss/domain/usecases/remote/playlist/GetPlaylistUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final GetEditPlaylistProvider = StateNotifierProvider<GetEditPlaylistProviderNotifier, UIState<ResponsePlaylistModel>>(
  (ref) => GetEditPlaylistProviderNotifier(),
);

class GetEditPlaylistProviderNotifier extends StateNotifier<UIState<ResponsePlaylistModel>> {
  GetEditPlaylistProviderNotifier() : super(Idle());

  GetPlaylistUseCase get _getPlaylistUseCase => GetIt.instance<GetPlaylistUseCase>();

  void requestPlaylistInfo(int playlistId) {
    _getPlaylistUseCase.call(playlistId).then((value) {
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
