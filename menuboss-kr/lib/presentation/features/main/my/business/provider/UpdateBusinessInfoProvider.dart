import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/business/RequestAddressModel.dart';
import 'package:menuboss/domain/usecases/remote/business/PatchBusinessAddressUseCase.dart';
import 'package:menuboss/domain/usecases/remote/business/PatchBusinessNameUseCase.dart';
import 'package:menuboss_common/utils/UiState.dart';

final updateBusinessAddressProvider =
StateNotifierProvider<UpdateBusinessInfoNotifier, UIState<String?>>(
      (_) => UpdateBusinessInfoNotifier(),
);

class UpdateBusinessInfoNotifier extends StateNotifier<UIState<String?>> {
  UpdateBusinessInfoNotifier() : super(Idle<String?>());

  PatchBusinessAddressUseCase get _patchAddressUseCase =>
      GetIt.instance<PatchBusinessAddressUseCase>();

  PatchBusinessNameUseCase get _patchBusinessNameUseCase =>
      GetIt.instance<PatchBusinessNameUseCase>();

  Future<void> updateBusinessInfo(RequestAddressModel addressModel, String title) async {
    state = Loading();
    try {
      final resultList = await Future.wait([
        _patchBusinessNameUseCase.call(title),
        _patchAddressUseCase.call(addressModel),
      ]);

      for (var result in resultList) {
        if (result.status != 200) {
          state = Failure(result.message);
          return;
        }
      }
      state = Success("");
    } catch (e) {
      state = Failure(e.toString());
    }
  }

  void init() => state = Idle();
}