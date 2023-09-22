import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/domain/usecases/remote/media/PatchMediaNameUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final MediaNameChangeProvider = StateNotifierProvider<MediaNameChangeNotifier, UIState<String?>>(
      (ref) => MediaNameChangeNotifier(),
);

class MediaNameChangeNotifier extends StateNotifier<UIState<String?>> {
  MediaNameChangeNotifier() : super(Idle());

  final PatchMediaNameUseCase _mediaNameUseCase = GetIt.instance<PatchMediaNameUseCase>();

  /// 미디어 이름 변경
  void requestChangeMediaName(String mediaId, String fileName) {
    state = Loading();
    _mediaNameUseCase.call(mediaId, fileName).then((response) {
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
