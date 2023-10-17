import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/me/RequestMeJoinModel.dart';
import 'package:menuboss/domain/usecases/remote/me/PostMeJoinUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final signUpProvider = StateNotifierProvider<LoginUiStateNotifier, UIState<String?>>(
  (_) => LoginUiStateNotifier(),
);

class LoginUiStateNotifier extends StateNotifier<UIState<String?>> {
  LoginUiStateNotifier() : super(Idle<String?>());

  PostMeJoinUseCase get _postMeJoinUseCase => GetIt.instance<PostMeJoinUseCase>();

  // 회원가입 요청
  void requestMeJoin(RequestMeJoinModel model) {
    state = Loading();
    _postMeJoinUseCase.call(model).then(
      (value) {
        if (value.status == 200 && value.data != null) {
          final accessToken = value.data?.accessToken;
          state = Success(accessToken);
        } else {
          state = Failure(value.message);
        }
      },
    );
  }

  void init() => state = Idle();
}
