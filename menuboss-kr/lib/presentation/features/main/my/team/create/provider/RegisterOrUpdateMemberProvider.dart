import 'dart:ffi';

import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/business/RequestTeamMemberModel.dart';
import 'package:menuboss/domain/usecases/remote/business/PatchMemberUseCase.dart';
import 'package:menuboss/domain/usecases/remote/business/PostMemberUseCase.dart';
import 'package:menuboss_common/utils/UiState.dart';

final registerOrUpdateMemberProvider =
    StateNotifierProvider<RegisterOrUpdateMemberNotifier, UIState<bool>>(
  (ref) => RegisterOrUpdateMemberNotifier(),
);

class RegisterOrUpdateMemberNotifier extends StateNotifier<UIState<bool>> {
  RegisterOrUpdateMemberNotifier() : super(Idle());

  final PostMemberUseCase _postMemberUseCase = GetIt.instance<PostMemberUseCase>();

  final PatchMemberUseCase _patchMemberUseCase = GetIt.instance<PatchMemberUseCase>();

  void updateMember({
    required int? memberId,
    required RequestTeamMemberModel model,
    int delay = 0,
  }) async {
    state = Loading();

    await Future.delayed(Duration(milliseconds: (delay)));

    if (memberId != null) {
      _patchMemberUseCase.call(model, memberId).then((response) {
        if (response.status == 200) {
          state = Success(false); // update
        } else {
          state = Failure(response.message);
        }
      });
    } else {
      _postMemberUseCase.call(model).then((response) {
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
