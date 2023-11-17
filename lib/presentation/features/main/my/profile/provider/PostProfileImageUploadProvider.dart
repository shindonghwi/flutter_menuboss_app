import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/domain/usecases/remote/file/PostUploadProfileImageUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final postProfileImageUploadProvider = StateNotifierProvider<PostProfileImageUploadNotifier, UIState<String?>>(
      (_) => PostProfileImageUploadNotifier(),
);

class PostProfileImageUploadNotifier extends StateNotifier<UIState<String?>> {
  PostProfileImageUploadNotifier() : super(Idle<String?>());

  PostUploadProfileImageUseCase get _postUploadUseCase => GetIt.instance<PostUploadProfileImageUseCase>();

  int imageId = -1;

  void requestUploadProfileImage(String? filePath) async {
    state = Loading();
    _postUploadUseCase.call(filePath.toString()).then((result) {
      if (result.status == 200) {
        imageId = result.data?.imageId ?? -1;
        state = Success("");
      } else {
        state = Failure(result.message);
      }
    });
  }

  void init() => state = Idle();
}
