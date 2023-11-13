import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/device/ResponseDeviceModel.dart';
import 'package:menuboss/domain/usecases/remote/device/DelDeviceUseCase.dart';
import 'package:menuboss/domain/usecases/remote/device/GetDeivcesUseCase.dart';
import 'package:menuboss/domain/usecases/remote/device/PatchDeviceNameUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final deviceListProvider = StateNotifierProvider<DeviceListNotifier, UIState<List<ResponseDeviceModel>>>(
  (ref) => DeviceListNotifier(),
);

class DeviceListNotifier extends StateNotifier<UIState<List<ResponseDeviceModel>>> {
  DeviceListNotifier() : super(Idle());

  final GetDevicesUseCase _getDevicesUseCase = GetIt.instance<GetDevicesUseCase>();
  final DelDeviceUseCase _delDeviceUseCase = GetIt.instance<DelDeviceUseCase>();
  final PatchDeviceNameUseCase _patchDeviceNameUseCase = GetIt.instance<PatchDeviceNameUseCase>();

  List<ResponseDeviceModel> currentDevices = [];

  /// 디바이스 리스트 조회
  void requestGetDevices({int delay = 300}) async{
    state = Loading();

    await Future.delayed(Duration(milliseconds: delay));

    _getDevicesUseCase.call().then((response) async {
      if (response.status == 200) {
        updateCurrentDevices(response.list?.toList() ?? []);
        state = Success(currentDevices);
      } else {
        state = Failure(response.message);
      }
    });
  }

  /// 디바이스 삭제
  Future<void> requestDelDevice(int screenId) async {
    final index = currentDevices.indexWhere((item) => item.screenId == screenId);

    if (index != -1) {
      final removedItem = currentDevices.removeAt(index);
      state = Success(currentDevices); // 아이템을 먼저 삭제

      await _delDeviceUseCase.call(screenId).then((response) async {
        await Future.delayed(const Duration(milliseconds: 300));
        if (response.status != 200) {
          // 실패한 경우 아이템을 복구하고 에러 메시지 표시
          currentDevices.insert(index, removedItem);
          state = Failure(response.message);
        }
        updateCurrentDevices(currentDevices);
      });
    }
  }

  /// 디바이스 이름 변경
  void requestPatchDeviceName(int screenId, String name) async {
    final index = currentDevices.indexWhere((item) => item.screenId == screenId);

    if (index != -1) {
      final itemToUpdate = currentDevices[index];
      final originalItem = itemToUpdate;
      final updatedItem = itemToUpdate.copyWith(name: name);
      final updatedDevices = [
        ...currentDevices.sublist(0, index),
        updatedItem,
        ...currentDevices.sublist(index + 1),
      ];

      state = Success(updatedDevices); // 아이템을 먼저 업데이트

      _patchDeviceNameUseCase.call(screenId, name).then((response) async {
        await Future.delayed(const Duration(milliseconds: 300));
        if (response.status != 200) {
          updatedDevices[index] = originalItem; // 원래 아이템으로 복구
          state = Success(updatedDevices);
          state = Failure(response.message);
        }
        updateCurrentDevices(updatedDevices);
      });
    }
  }

  void updateCurrentDevices(List<ResponseDeviceModel> devices) {
    currentDevices = devices;
  }

  void init() => state = Idle();
}
