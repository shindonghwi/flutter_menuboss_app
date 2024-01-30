import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/domain/usecases/remote/business/DelRoleUseCase.dart';
import 'package:menuboss_common/utils/UiState.dart';

final delRoleProvider = StateNotifierProvider<DelRoleNotifier, UIState<String?>>(
  (ref) => DelRoleNotifier(),
);

class DelRoleNotifier extends StateNotifier<UIState<String?>> {
  DelRoleNotifier() : super(Idle());

  DelRoleUseCase get _delRoleUseCase => GetIt.instance<DelRoleUseCase>();

  void removeRole(int roleId) async {
    state = Loading();
    final response = await _delRoleUseCase.call(roleId);
    if (response.status == 200) {
      state = Success(roleId.toString());
    } else {
      state = Failure(response.message);
    }
  }

  void init() => state = Idle();
}
