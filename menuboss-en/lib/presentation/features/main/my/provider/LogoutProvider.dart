import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/data_source/remote/HeaderKey.dart';
import 'package:menuboss/data/data_source/remote/Service.dart';
import 'package:menuboss/domain/usecases/local/app/PostLoginAccessTokenUseCase.dart';
import 'package:menuboss/domain/usecases/remote/auth/PostLogoutUseCase.dart';
import 'package:menuboss_common/utils/UiState.dart';

final logoutProvider = StateNotifierProvider<LogoutUiStateNotifier, UIState<String?>>(
  (_) => LogoutUiStateNotifier(),
);

class LogoutUiStateNotifier extends StateNotifier<UIState<String?>> {
  LogoutUiStateNotifier() : super(Idle<String?>());

  PostLoginAccessTokenUseCase get _postLoginAccessToken => GetIt.instance<PostLoginAccessTokenUseCase>();

  PostLogoutUseCase get _postLogout => GetIt.instance<PostLogoutUseCase>();

  void requestLogout() async {
    state = Loading();

    await _postLogout.call().then((result) {
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
