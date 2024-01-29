import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/business/RequestRoleModel.dart';
import 'package:menuboss/data/models/business/RequestTeamMemberModel.dart';
import 'package:menuboss/domain/usecases/remote/business/PatchMemberUseCase.dart';
import 'package:menuboss/domain/usecases/remote/business/PatchRoleUseCase.dart';
import 'package:menuboss/domain/usecases/remote/business/PostMemberUseCase.dart';
import 'package:menuboss/domain/usecases/remote/business/PostRoleUseCase.dart';
import 'package:menuboss_common/utils/UiState.dart';

final registerOrUpdateRoleProvider =
    StateNotifierProvider<RegisterOrUpdateRoleNotifier, UIState<bool>>(
  (ref) => RegisterOrUpdateRoleNotifier(),
);

class RegisterOrUpdateRoleNotifier extends StateNotifier<UIState<bool>> {
  RegisterOrUpdateRoleNotifier() : super(Idle());

  final PostRoleUseCase _postRoleUseCase = GetIt.instance<PostRoleUseCase>();

  final PatchRoleUseCase _patchRoleUseCase = GetIt.instance<PatchRoleUseCase>();

  void updateRole({
    required int? roleId,
    required RequestRoleModel model,
    int delay = 600,
  }) async {
    state = Loading();

    if (roleId != null) {
      _patchRoleUseCase.call(model, roleId).then((response) async{
        await Future.delayed(Duration(milliseconds: (delay)));
        if (response.status == 200) {
          state = Success(false); // update
        } else {
          state = Failure(response.message);
        }
      });
    } else {
      _postRoleUseCase.call(model).then((response) async{
        await Future.delayed(Duration(milliseconds: (delay)));
        if (response.status == 200) {
          state = Success(true); // register
        } else {
          state = Failure(response.message);
        }
      });
    }
  }

  void init() {
    state = Idle();
  }
}