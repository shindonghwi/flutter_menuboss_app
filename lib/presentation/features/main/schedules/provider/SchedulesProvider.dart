import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/schedule/ResponseScheduleModel.dart';
import 'package:menuboss/domain/usecases/remote/schedule/GetSchedulesUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final schedulesProvider = StateNotifierProvider<SchedulesNotifier, UIState<List<ResponseScheduleModel>>>(
  (ref) => SchedulesNotifier(),
);

class SchedulesNotifier extends StateNotifier<UIState<List<ResponseScheduleModel>>> {
  SchedulesNotifier() : super(Idle());

  final GetSchedulesUseCase _getSchedulesUseCase = GetIt.instance<GetSchedulesUseCase>();

  void requestGetSchedules() {
    state = Loading();
    _getSchedulesUseCase.call().then((response) {
      if (response.status == 200) {
        state = Success(response.list?.map((e) => e.toUpDatedAtSimpleMapper()).toList() ?? []);
      } else {
        state = Failure(response.message);
      }
    });
  }

  void init() {
    state = Idle();
  }
}
