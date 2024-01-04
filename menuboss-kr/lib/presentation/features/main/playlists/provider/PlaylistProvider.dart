import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistsModel.dart';
import 'package:menuboss/domain/usecases/remote/playlist/GetPlaylistsUseCase.dart';
import 'package:menuboss_common/utils/UiState.dart';

final playListProvider =
    StateNotifierProvider<PlayListNotifier, UIState<List<ResponsePlaylistsModel>>>(
  (ref) => PlayListNotifier(),
);

class PlayListNotifier extends StateNotifier<UIState<List<ResponsePlaylistsModel>>> {
  PlayListNotifier() : super(Idle());

  final GetPlaylistsUseCase _getPlaylistsUseCase = GetIt.instance<GetPlaylistsUseCase>();

  void requestGetPlaylists({int delay = 0}) async {
    state = Loading();

    await Future.delayed(Duration(milliseconds: (delay)));

    return _getPlaylistsUseCase.call().then((response) {
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
