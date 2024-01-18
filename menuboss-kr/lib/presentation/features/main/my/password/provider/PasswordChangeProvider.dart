import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/domain/usecases/remote/me/PatchMePasswordUseCase.dart';
import 'package:menuboss_common/utils/UiState.dart';

final passwordChangeProvider =
    StateNotifierProvider<PasswordChangeUiStateNotifier, UIState<String?>>(
  (_) => PasswordChangeUiStateNotifier(),
);

class PasswordChangeUiStateNotifier extends StateNotifier<UIState<String?>> {
  PasswordChangeUiStateNotifier() : super(Idle<String?>());

  PatchMePasswordUseCase get _patchPassword => GetIt.instance<PatchMePasswordUseCase>();

  var _password = "";

  void updatePassword(String password) => _password = password;

  void requestChangePassword() async {
    state = Loading();
    await _patchPassword.call(_password).then((result) {
      if (result.status == 200) {
        state = Success("");
      } else {
        state = Failure(result.message);
      }
    });
  }

  void init() => state = Idle();
}
