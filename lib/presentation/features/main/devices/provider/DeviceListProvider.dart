import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/device/ResponseDeviceModel.dart';
import 'package:menuboss/domain/usecases/remote/device/DelDeviceUseCase.dart';
import 'package:menuboss/domain/usecases/remote/device/GetDeivcesUseCase.dart';
import 'package:menuboss/domain/usecases/remote/device/PatchDeviceNameUseCase.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/model/UiState.dart';

import '../widget/DeviceItem.dart';

final DeviceListProvider = StateNotifierProvider<DeviceListNotifier, UIState<List<ResponseDeviceModel>>>(
  (ref) => DeviceListNotifier(),
);

class DeviceListNotifier extends StateNotifier<UIState<List<ResponseDeviceModel>>> {
  DeviceListNotifier() : super(Idle());

  final GetDevicesUseCase _getDevicesUseCase = GetIt.instance<GetDevicesUseCase>();
  final DelDeviceUseCase _delDeviceUseCase = GetIt.instance<DelDeviceUseCase>();
  final PatchDeviceNameUseCase _patchDeviceNameUseCase = GetIt.instance<PatchDeviceNameUseCase>();

  void requestGetDevices() {
    state = Loading();
    _getDevicesUseCase.call().then((response) {
      if (response.status == 200) {
        state = Success(response.list?.reversed.toList() ?? []);
      } else {
        state = Failure(response.message);
      }
    });
  }

  void requestDelDevice(int screenId, GlobalKey<AnimatedListState>? listKey) {
    _delDeviceUseCase.call(screenId).then((response) {
      if (response.status == 200) {
        if (state is Success<List<ResponseDeviceModel>>) {
          final items = (state as Success<List<ResponseDeviceModel>>).value;
          final index = items.indexWhere((item) => item.screenId == screenId);

          if (index != -1) {
            final itemToRemove = items[index];
            listKey?.currentState?.removeItem(index, (context, animation) {
              return _animatedItemBuilder(itemToRemove, animation, listKey, isRenamed: false);
            }, duration: const Duration(milliseconds: 300));
            Future.delayed(const Duration(milliseconds: 300), () {
              state = Success([...items]..remove(itemToRemove));
            });
          }
        }
      } else {
        state = Failure(response.message);
      }
    });
  }

  void requestPatchDeviceName(int screenId, String name, GlobalKey<AnimatedListState>? listKey) {
    _patchDeviceNameUseCase.call(screenId, name).then((response) {
      if (response.status == 200) {
        if (state is Success<List<ResponseDeviceModel>>) {
          final items = (state as Success<List<ResponseDeviceModel>>).value;
          final index = items.indexWhere((item) => item.screenId == screenId);

          if (index != -1) {
            final itemToUpdate = items[index];
            final updatedItem = itemToUpdate.copyWith(name: name);

            listKey?.currentState?.removeItem(index, (context, animation) {
              return _animatedItemBuilder(itemToUpdate, animation, listKey, isRenamed: true);
            }, duration: const Duration(milliseconds: 300));

            Future.delayed(const Duration(milliseconds: 300), () {
              state = Success([
                ...items.sublist(0, index),
                updatedItem,
                ...items.sublist(index + 1),
              ]);
            });
          }
        }
      } else {
        state = Failure(response.message);
      }
    });
  }

  Widget _animatedItemBuilder(
      ResponseDeviceModel item, Animation<double> animation, GlobalKey<AnimatedListState> listKey,
      {required bool isRenamed}) {
    final fadeAnimation = isRenamed
        ? TweenSequence([
            TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.5), weight: 0.5),
            TweenSequenceItem(tween: Tween<double>(begin: 0.5, end: 1.0), weight: 0.5),
          ]).animate(animation)
        : null;

    if (isRenamed) {
      return FadeTransition(
        opacity: fadeAnimation!,
        child: DeviceItem(
          item: item,
          listKey: listKey,
        ),
      );
    } else {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-0.6, 0),
          end: Offset.zero,
        ).animate(animation),
        child: DeviceItem(
          item: item,
          listKey: listKey,
        ),
      );
    }
  }
}
