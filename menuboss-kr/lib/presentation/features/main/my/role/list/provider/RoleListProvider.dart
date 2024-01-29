import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/business/ResponseBusinessMemberModel.dart';
import 'package:menuboss/data/models/business/ResponseRoleModel.dart';
import 'package:menuboss/domain/usecases/remote/business/GetRolesUseCase.dart';
import 'package:menuboss_common/utils/UiState.dart';

final roleListProvider =
    StateNotifierProvider<RoleListNotifier, UIState<List<ResponseRoleModel>>>(
  (ref) => RoleListNotifier(),
);

class RoleListNotifier extends StateNotifier<UIState<List<ResponseRoleModel>>> {
  RoleListNotifier() : super(Idle());

  final GetRolesUseCase _getRolesUseCase = GetIt.instance<GetRolesUseCase>();

  final currentRoleList = <ResponseRoleModel>[];

  void requestGetRoles({int delay = 0}) async {
    state = Loading();

    await Future.delayed(Duration(milliseconds: (delay)));

    _getRolesUseCase.call().then((response) {
      if (response.status == 200) {
        currentRoleList.clear();
        currentRoleList.addAll(response.list ?? []);
        state = Success(currentRoleList);
      } else {
        state = Failure(response.message);
      }
    });
  }

  void removeRoleById(int roleId) async {
    currentRoleList.removeWhere((element) => element.roleId == roleId);
    state = Success([...currentRoleList]);
  }

  void init() {
    state = Idle();
  }
}
