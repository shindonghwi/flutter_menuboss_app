import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/business/ResponseBusinessMemberModel.dart';
import 'package:menuboss/domain/usecases/remote/business/GetBusinessMembersUseCase.dart';
import 'package:menuboss_common/utils/UiState.dart';

final registerMemberProvider =
    StateNotifierProvider<RegisterMemberNotifier, UIState<List<ResponseBusinessMemberModel>>>(
  (ref) => RegisterMemberNotifier(),
);

class RegisterMemberNotifier extends StateNotifier<UIState<List<ResponseBusinessMemberModel>>> {
  RegisterMemberNotifier() : super(Idle());

  final GetBusinessMembersUseCase _getBusinessMembersUseCase =
      GetIt.instance<GetBusinessMembersUseCase>();

  void requestGetTeamMember({int delay = 0}) async {
    state = Loading();

    await Future.delayed(Duration(milliseconds: (delay)));

    _getBusinessMembersUseCase.call().then((response) {
      if (response.status == 200) {
        state = Success(response.list?.map((e) => e).toList() ?? []);
      } else {
        state = Failure(response.message);
      }
    });
  }

  void init() {
    state = Idle();
  }
}
