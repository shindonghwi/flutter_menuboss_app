import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistTime.dart';
import 'package:menuboss/data/models/schedule/RequestScheduleUpdateInfoModel.dart';
import 'package:menuboss/data/models/schedule/RequestScheduleUpdateInfoPlan.dart';
import 'package:menuboss/data/models/schedule/RequestScheduleUpdateInfoPlaylist.dart';
import 'package:menuboss/data/models/schedule/SimpleSchedulesModel.dart';
import 'package:menuboss/domain/usecases/remote/schedule/PostPlaylistUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final ScheduleRegisterProvider = StateNotifierProvider<ScheduleRegisterProviderNotifier, UIState<String?>>(
  (ref) => ScheduleRegisterProviderNotifier(),
);

class ScheduleRegisterProviderNotifier extends StateNotifier<UIState<String?>> {
  ScheduleRegisterProviderNotifier() : super(Idle());

  PostScheduleUseCase get _postScheduleUseCase => GetIt.instance<PostScheduleUseCase>();

  void registerSchedule(RequestScheduleUpdateInfoModel data) {
    state = Loading();
    _postScheduleUseCase.call(data).then((response) async{
      if (response.status == 200) {
        await Future.delayed(Duration(seconds: 1));
        state = Success(response.data?.scheduleId.toString());
      } else {
        state = Failure(response.message);
      }
    });
  }

  void init() {
    state = Idle();
  }
}
