import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/domain/usecases/remote/schedule/GetScheduleUseCase.dart';
import 'package:menuboss_common/utils/UiState.dart';

import '../../../../../data/models/schedule/ResponseScheduleModel.dart';

final getScheduleProvider = StateNotifierProvider<GetScheduleNotifier, UIState<ResponseScheduleModel>>(
  (ref) => GetScheduleNotifier(),
);

class GetScheduleNotifier extends StateNotifier<UIState<ResponseScheduleModel>> {
  GetScheduleNotifier() : super(Idle());

  GetScheduleUseCase get _getScheduleUseCase => GetIt.instance<GetScheduleUseCase>();

  void requestScheduleInfo(int scheduleId) {
    state = Loading();
    _getScheduleUseCase.call(scheduleId).then((value) async {
      if (value.status == 200) {
        if (value.data != null) {
          state = Success(value.data!);
        } else {
          state = Failure(value.message);
        }
      } else {
        state = Failure(value.message);
      }
    });
  }

  void init() {
    state = Idle();
  }
}
