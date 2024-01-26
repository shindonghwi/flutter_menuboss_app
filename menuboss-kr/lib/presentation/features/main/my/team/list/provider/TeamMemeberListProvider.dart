import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/business/ResponseBusinessMemberModel.dart';
import 'package:menuboss/domain/usecases/remote/business/GetBusinessMembersUseCase.dart';
import 'package:menuboss_common/utils/UiState.dart';

final teamMemberListProvider =
    StateNotifierProvider<TeamMemberListNotifier, UIState<List<ResponseBusinessMemberModel>>>(
  (ref) => TeamMemberListNotifier(),
);

class TeamMemberListNotifier extends StateNotifier<UIState<List<ResponseBusinessMemberModel>>> {
  TeamMemberListNotifier() : super(Idle());

  final GetBusinessMembersUseCase _getBusinessMembersUseCase =
      GetIt.instance<GetBusinessMembersUseCase>();

  final currentMemberList = <ResponseBusinessMemberModel>[];

  void requestGetTeamMember({int delay = 0}) async {
    state = Loading();

    await Future.delayed(Duration(milliseconds: (delay)));

    _getBusinessMembersUseCase.call().then((response) {
      if (response.status == 200) {
        currentMemberList.clear();
        currentMemberList.addAll(response.list ?? []);
        state = Success(currentMemberList);
      } else {
        state = Failure(response.message);
      }
    });
  }

  void removeMemberById(int memberId) async {
    currentMemberList.removeWhere((element) => element.memberId == memberId);
    state = Success([...currentMemberList]);
  }

  void init() {
    state = Idle();
  }
}
