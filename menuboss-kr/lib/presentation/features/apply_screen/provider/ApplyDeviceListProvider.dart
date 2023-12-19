import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/device/ResponseDeviceModel.dart';
import 'package:menuboss/domain/usecases/remote/device/GetDeivcesUseCase.dart';
import 'package:menuboss_common/utils/UiState.dart';

final applyDeviceListProvider = StateNotifierProvider<ApplyDeviceListNotifier, UIState<List<ResponseDeviceModel>>>(
  (ref) => ApplyDeviceListNotifier(),
);

class ApplyDeviceListNotifier extends StateNotifier<UIState<List<ResponseDeviceModel>>> {
  ApplyDeviceListNotifier() : super(Idle());

  final GetDevicesUseCase _getDevicesUseCase = GetIt.instance<GetDevicesUseCase>();

  List<ResponseDeviceModel> currentDevices = [];

  /// 디바이스 리스트 조회
  void requestGetDevices() async {
    state = Loading();

    await Future.delayed(const Duration(milliseconds: 600));

    _getDevicesUseCase.call().then((response) async {
      if (response.status == 200) {
        state = Success(currentDevices);
      } else {
        state = Failure(response.message);
      }
    });
  }

  void init() => state = Idle();
}
