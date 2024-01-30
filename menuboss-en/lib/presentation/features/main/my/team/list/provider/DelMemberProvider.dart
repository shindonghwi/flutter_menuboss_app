import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/domain/usecases/remote/business/DelMemberUseCase.dart';
import 'package:menuboss_common/utils/UiState.dart';

final delMemberProvider = StateNotifierProvider<DelMemberNotifier, UIState<String?>>(
  (ref) => DelMemberNotifier(),
);

class DelMemberNotifier extends StateNotifier<UIState<String?>> {
  DelMemberNotifier() : super(Idle());

  DelMemberUseCase get _delMemberUseCase => GetIt.instance<DelMemberUseCase>();

  void removeMember(int memberId) async {
    state = Loading();
    final response = await _delMemberUseCase.call(memberId);
    if (response.status == 200) {
      state = Success(memberId.toString());
    } else {
      state = Failure(response.message);
    }
  }

  void init() => state = Idle();
}
