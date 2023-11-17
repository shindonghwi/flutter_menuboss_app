import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/domain/usecases/remote/device/PostShowNameEventUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final deviceShowNameEventProvider = StateNotifierProvider<DeviceShowNameEventNotifier, UIState<String?>>(
  (ref) => DeviceShowNameEventNotifier(),
);

class DeviceShowNameEventNotifier extends StateNotifier<UIState<String?>> {
  DeviceShowNameEventNotifier() : super(Idle());

  final PostShowNameEventUseCase _postShowNameEventUseCase = GetIt.instance<PostShowNameEventUseCase>();

  /// 이름 표시 이벤트 요청
  void requestSendNameShowEvent(int screenId) async {
    state = Loading();

    _postShowNameEventUseCase.call(screenId).then((response) async {
      if (response.status == 200) {
        state = Success("");
      } else {
        state = Failure(response.message);
      }
    });
  }

  void init() => state = Idle();
}
