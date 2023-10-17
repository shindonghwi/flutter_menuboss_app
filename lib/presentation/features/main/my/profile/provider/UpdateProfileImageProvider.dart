import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/domain/usecases/remote/file/PostUploadProfileImageUseCase.dart';
import 'package:menuboss/domain/usecases/remote/me/PatchMeProfileImageUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final updateProfileImageProvider = StateNotifierProvider<UpdateProfileImageNotifier, UIState<String?>>(
      (_) => UpdateProfileImageNotifier(),
);

class UpdateProfileImageNotifier extends StateNotifier<UIState<String?>> {
  UpdateProfileImageNotifier() : super(Idle<String?>());

  PatchMeProfileImageUseCase get _patchMeProfileImageUseCase => GetIt.instance<PatchMeProfileImageUseCase>();

  void requestUploadProfileImage(int imageId) async {
    state = Loading();
    _patchMeProfileImageUseCase.call(imageId).then((result) {
      if (result.status == 200) {
        state = Success(result.data?.imageUrl);
      } else {
        state = Failure(result.message);
      }
    });
  }

  void init() => state = Idle();
}
