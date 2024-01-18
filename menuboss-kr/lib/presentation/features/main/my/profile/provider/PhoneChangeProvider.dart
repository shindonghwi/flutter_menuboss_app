import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/domain/usecases/remote/me/PatchMeNameUseCase.dart';
import 'package:menuboss/domain/usecases/remote/me/PatchMePhoneUseCase.dart';
import 'package:menuboss_common/utils/UiState.dart';

final phoneChangeProvider = StateNotifierProvider<NameChangeUiStateNotifier, UIState<String?>>(
      (_) => NameChangeUiStateNotifier(),
);

class NameChangeUiStateNotifier extends StateNotifier<UIState<String?>> {
  NameChangeUiStateNotifier() : super(Idle<String?>());


  PatchMePhoneUseCase get _patchPhone => GetIt.instance<PatchMePhoneUseCase>();

  var _phone = "";
  void updatePhone(String phone) => _phone = phone;
  String getPhone() => _phone;

  void requestChangePhone() async {
    state = Loading();
    await _patchPhone.call(_phone).then((result) {
      if (result.status == 200) {
        state = Success("");
      } else {
        state = Failure(result.message);
      }
    });
  }

  void init() => state = Idle();
}
