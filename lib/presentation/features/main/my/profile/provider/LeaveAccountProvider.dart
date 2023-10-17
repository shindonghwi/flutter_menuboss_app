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
import 'package:menuboss/domain/usecases/remote/me/PostMeLeaveUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';

final leaveAccountProvider = StateNotifierProvider<LeaveAccountNotifier, UIState<String?>>(
      (_) => LeaveAccountNotifier(),
);

class LeaveAccountNotifier extends StateNotifier<UIState<String?>> {
  LeaveAccountNotifier() : super(Idle<String?>());


  PostMeLeaveUseCase get _postMeLeaveUseCase => GetIt.instance<PostMeLeaveUseCase>();
  PostLoginAccessTokenUseCase get _postLoginAccessToken => GetIt.instance<PostLoginAccessTokenUseCase>();

  String? currentReason = null;

  void requestMeLeave() async {
    state = Loading();

    await _postMeLeaveUseCase.call(currentReason).then((result) {
      if (result.status == 200) {
        saveAccessToken("");
        state = Success("");
      } else {
        state = Failure(result.message);
      }
    });
  }

  void saveAccessToken(String accessToken) async {
    await _postLoginAccessToken.call(accessToken);
    Service.addHeader(key: HeaderKey.Authorization, value: accessToken);
  }

  void init() => state = Idle();
}
