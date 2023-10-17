import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/data_source/remote/HeaderKey.dart';
import 'package:menuboss/data/data_source/remote/Service.dart';
import 'package:menuboss/data/models/me/ResponseMeInfoModel.dart';
import 'package:menuboss/domain/usecases/local/app/PostLoginAccessTokenUseCase.dart';
import 'package:menuboss/domain/usecases/remote/auth/PostEmailUseCase.dart';
import 'package:menuboss/domain/usecases/remote/auth/PostLogoutUseCase.dart';
import 'package:menuboss/domain/usecases/remote/me/GetMeInfoUseCase.dart';
import 'package:menuboss/domain/usecases/remote/me/PatchMeNameUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';

final nameChangeProvider = StateNotifierProvider<NameChangeUiStateNotifier, UIState<String?>>(
      (_) => NameChangeUiStateNotifier(),
);

class NameChangeUiStateNotifier extends StateNotifier<UIState<String?>> {
  NameChangeUiStateNotifier() : super(Idle<String?>());


  PatchMeNameUseCase get _patchName => GetIt.instance<PatchMeNameUseCase>();

  var _name = "";
  void updateName(String name) => _name = name;
  String getName() => _name;

  void requestChangeName() async {
    state = Loading();

    await _patchName.call(_name).then((result) {
      if (result.status == 200) {
        state = Success("");
      } else {
        state = Failure(result.message);
      }
    });
  }

  void init() => state = Idle();
}
