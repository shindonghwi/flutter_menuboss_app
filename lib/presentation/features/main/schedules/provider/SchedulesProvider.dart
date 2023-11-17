import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/schedule/ResponseSchedulesModel.dart';
import 'package:menuboss/domain/usecases/remote/schedule/GetSchedulesUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final schedulesProvider = StateNotifierProvider<SchedulesNotifier, UIState<List<ResponseSchedulesModel>>>(
  (ref) => SchedulesNotifier(),
);

class SchedulesNotifier extends StateNotifier<UIState<List<ResponseSchedulesModel>>> {
  SchedulesNotifier() : super(Idle());

  final GetSchedulesUseCase _getSchedulesUseCase = GetIt.instance<GetSchedulesUseCase>();

  void requestGetSchedules({int delay = 0}) async{
    state = Loading();

    await Future.delayed(Duration(milliseconds: delay));

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
