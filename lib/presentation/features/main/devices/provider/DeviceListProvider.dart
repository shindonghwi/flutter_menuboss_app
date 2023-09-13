import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/device/ResponseDeviceModel.dart';
import 'package:menuboss/domain/usecases/remote/device/GetDeivcesUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final DeviceListProvider = StateNotifierProvider<DeviceListNotifier, UIState<List<ResponseDeviceModel>>>(
  (ref) => DeviceListNotifier(),
);

class DeviceListNotifier extends StateNotifier<UIState<List<ResponseDeviceModel>>> {
  DeviceListNotifier() : super(Idle());

  final GetDevicesUseCase _getDevicesUseCase = GetIt.instance<GetDevicesUseCase>();

  void requestGetDevices() {
    _getDevicesUseCase.call().then((response) {
      state = Loading();
      if (response.status == 200) {
        state = Success(response.list?.reversed.toList() ?? []);
      } else {
        state = Failure(response.message);
      }
    });
  }

// void addItem(DeviceListModel item, {GlobalKey<AnimatedListState>? listKey}) {
//   listKey?.currentState?.insertItem(0, duration: const Duration(milliseconds: 300));
//   state = [item, ...state];
// }

// void removeItem(DeviceListModel item, GlobalKey<AnimatedListState>? listKey) {
//   final index = state.indexOf(item);
//   if (index != -1) {
//     listKey?.currentState?.removeItem(index, (context, animation) {
//       return _animatedItemBuilder(item, animation, listKey);
//     }, duration: const Duration(milliseconds: 300));
//     Future.delayed(const Duration(milliseconds: 300), () {
//       state = [...state]..remove(item);
//     });
//   }
// }
//
// Widget _animatedItemBuilder(
//   DeviceListModel item,
//   Animation<double> animation,
//   GlobalKey<AnimatedListState> listKey,
// ) {
//   return SlideTransition(
//     position: Tween<Offset>(
//       begin: const Offset(-0.6, 0),
//       end: Offset.zero,
//     ).animate(animation),
//     child: DeviceItem(
//       item: item,
//       listKey: listKey,
//     ),
//   );
// }
//
// void renameItem(DeviceListModel oldItem, String newScreenName) {
//   int index = state.indexOf(oldItem);
//   if (index != -1) {
//     DeviceListModel updatedItem = oldItem.copyWith(screenName: newScreenName);
//     state = [
//       ...state.sublist(0, index),
//       updatedItem,
//       ...state.sublist(index + 1),
//     ];
//   }
// }
}
