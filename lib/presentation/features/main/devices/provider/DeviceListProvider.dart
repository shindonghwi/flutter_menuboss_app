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

  void requestGetDevices() {
    state = Loading();
    _getDevicesUseCase.call().then((response) {
      if (response.status == 200) {
        currentDevices = response.list?.toList() ?? [];
        state = Success(currentDevices);
      } else {
        state = Failure(response.message);
      }
    }).then((value) => Future.delayed(const Duration(milliseconds: 300), () => init()));
  }

  void requestDelDevice(int screenId) {
    state = Loading();
    _delDeviceUseCase.call(screenId).then((response) {
      if (response.status == 200) {
        final index = currentDevices.indexWhere((item) => item.screenId == screenId);
        if (index != -1) {
          final itemToRemove = currentDevices[index];
          state = Success([...currentDevices]..remove(itemToRemove));
        }
      } else {
        state = Failure(response.message);
      }
    }).then((value) => Future.delayed(const Duration(milliseconds: 300), () => init()));
  }

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
    }).then((value) => Future.delayed(const Duration(milliseconds: 300), () => init()));
  }

  void init() => state = Idle();
}
