import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/RequestPlaylistUpdateInfoModel.dart';
import 'package:menuboss/data/models/schedule/RequestScheduleUpdateInfoModel.dart';
import 'package:menuboss/domain/usecases/remote/playlist/PatchPlaylistUseCase.dart';
import 'package:menuboss/domain/usecases/remote/schedule/PatchScheduleUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final scheduleUpdateProvider = StateNotifierProvider<ScheduleUpdate, UIState<String?>>(
  (ref) => ScheduleUpdate(),
);

class ScheduleUpdate extends StateNotifier<UIState<String?>> {
  ScheduleUpdate() : super(Idle());

  final PatchScheduleUseCase _patchScheduleUseCase = GetIt.instance<PatchScheduleUseCase>();

  void updateSchedule(int scheduleId, RequestScheduleUpdateInfoModel model){
    state = Loading();

    _patchScheduleUseCase.call(scheduleId, model).then((response) async {
      if (response.status == 200) {
        state = Success(response.message);
      } else {
        state = Failure(response.message);
      }
    });
  }

  void init() {
    state = Idle();
  }
}
