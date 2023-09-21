import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/device/ResponseDeviceModel.dart';
import 'package:menuboss/domain/usecases/remote/device/DelDeviceUseCase.dart';
import 'package:menuboss/domain/usecases/remote/device/GetDeivcesUseCase.dart';
import 'package:menuboss/domain/usecases/remote/device/PatchDeviceNameUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final DeviceListProvider = StateNotifierProvider<DeviceListNotifier, UIState<List<ResponseDeviceModel>>>(
  (ref) => DeviceListNotifier(),
);

class DeviceListNotifier extends StateNotifier<UIState<List<ResponseDeviceModel>>> {
  DeviceListNotifier() : super(Idle());

  final GetDevicesUseCase _getDevicesUseCase = GetIt.instance<GetDevicesUseCase>();
  final DelDeviceUseCase _delDeviceUseCase = GetIt.instance<DelDeviceUseCase>();
  final PatchDeviceNameUseCase _patchDeviceNameUseCase = GetIt.instance<PatchDeviceNameUseCase>();

  List<ResponseDeviceModel> currentDevices = [];

  /// 디바이스 리스트 조회
  void requestGetDevices() {
    state = Loading();
    _getDevicesUseCase.call().then((response) async {
      if (response.status == 200) {
        currentDevices = response.list?.toList() ?? [];
        state = Success(currentDevices);
      } else {
        state = Failure(response.message);
      }
    });
  }

  /// 디바이스 삭제
  void requestDelDevice(int screenId) {
    state = Loading();
    _delDeviceUseCase.call(screenId).then((response) {
      if (response.status == 200) {
        final index = currentDevices.indexWhere((item) => item.screenId == screenId);
        if (index != -1) {
          state = Success([...currentDevices]..remove(currentDevices[index]));
        }
      } else {
        state = Failure(response.message);
      }
    });
  }

  /// 디바이스 이름 변경
  void requestPatchDeviceName(int screenId, String name) {
    state = Loading();
    _patchDeviceNameUseCase.call(screenId, name).then((response) {
      if (response.status == 200) {
        final index = currentDevices.indexWhere((item) => item.screenId == screenId);

        if (index != -1) {
          final itemToUpdate = currentDevices[index];
          final updatedItem = itemToUpdate.copyWith(name: name);
          state = Success([
            ...currentDevices.sublist(0, index),
            updatedItem,
            ...currentDevices.sublist(index + 1),
          ]);
        }
      } else {
        state = Failure(response.message);
      }
    });
  }

  void init({
    bool isDelayMode = false,
  }) {
    Future.delayed(Duration(milliseconds: isDelayMode ? 300 : 0), () => state = Idle());
  }
}
