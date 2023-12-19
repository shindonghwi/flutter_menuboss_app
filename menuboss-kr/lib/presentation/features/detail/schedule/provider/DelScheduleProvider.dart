import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/domain/usecases/remote/schedule/DelScheduleUseCase.dart';
import 'package:menuboss_common/utils/UiState.dart';

final delScheduleProvider = StateNotifierProvider<DelScheduleNotifier, UIState<String?>>(
  (ref) => DelScheduleNotifier(),
);

class DelScheduleNotifier extends StateNotifier<UIState<String?>> {
  DelScheduleNotifier() : super(Idle());

  DelScheduleUseCase get _delScheduleUseCase => GetIt.instance<DelScheduleUseCase>();

  void removeSchedule(int scheduleId) {
    state = Loading();
    _delScheduleUseCase.call(scheduleId).then((value) {
      if (value.status == 200) {
        state = Success(value.message);
      } else {
        state = Failure(value.message);
      }
    });
  }

  void init() {
    state = Idle();
  }
}
