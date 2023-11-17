import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/domain/usecases/remote/media/PostMediaMoveUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final FileMoveProvider = StateNotifierProvider<FileMoveNotifier, UIState<String?>>(
  (ref) => FileMoveNotifier(),
);

class FileMoveNotifier extends StateNotifier<UIState<String?>> {
  FileMoveNotifier() : super(Idle());

  final PostMediaMoveUseCase _getMediaMoveUseCase = GetIt.instance<PostMediaMoveUseCase>();

  Future<void> requestFileMove(List<String> mediaIds, String? folderId, String folderName) async {
    state = Loading();

    _getMediaMoveUseCase.call(mediaIds, folderId: folderId).then((response) {
      if (response.status == 200) {
        state = Success(folderName);
      } else {
        state = Failure(response.message);
      }
    });
  }

  Future<Idle<String?>> init() {
    return Future(() => state = Idle());
  }
}
