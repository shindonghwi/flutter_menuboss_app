import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/data_source/remote/HeaderKey.dart';
import 'package:menuboss/data/data_source/remote/Service.dart';
import 'package:menuboss/data/models/me/RequestMeJoinModel.dart';
import 'package:menuboss/data/models/me/RequestMeSocialJoinModel.dart';
import 'package:menuboss/domain/usecases/local/app/PostLoginAccessTokenUseCase.dart';
import 'package:menuboss/domain/usecases/remote/me/PostMeJoinUseCase.dart';
import 'package:menuboss/domain/usecases/remote/me/PostMeSocialJoinUseCase.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/UiState.dart';


final signUpProvider = StateNotifierProvider<SignUpNotifier, UIState<String?>>(
  (_) => SignUpNotifier(),
);

class SignUpNotifier extends StateNotifier<UIState<String?>> {
  SignUpNotifier() : super(Idle<String?>());

  PostMeJoinUseCase get _postMeJoinUseCase => GetIt.instance<PostMeJoinUseCase>();

  PostMeSocialJoinUseCase get _postMeSocialJoinUseCase => GetIt.instance<PostMeSocialJoinUseCase>();

  PostLoginAccessTokenUseCase get _postLoginAccessToken => GetIt.instance<PostLoginAccessTokenUseCase>();

  // 회원가입 요청
  void requestMeJoin(RequestMeJoinModel model) async {
    state = Loading();
    _postMeJoinUseCase.call(model).then(
      (value) {
        if (value.status == 200 && value.data != null) {
          final accessToken = value.data?.accessToken;

          // me 호출시 accessToken이 변경되었을 경우, Service에 변경된 accessToken을 적용
          if (!CollectionUtil.isNullEmptyFromString(accessToken)) {
            saveAccessToken(accessToken.toString());
          }
          state = Success(accessToken);
        } else {
          state = Failure(value.message);
        }
      },
    );
  }

  // 소셜 회원가입 요청
  void requestMeSocialJoin(RequestMeSocialJoinModel model) async {
    state = Loading();
    _postMeSocialJoinUseCase.call(model).then(
      (value) {
        if (value.status == 200 && value.data != null) {
          final accessToken = value.data?.accessToken;

          // me 호출시 accessToken이 변경되었을 경우, Service에 변경된 accessToken을 적용
          if (!CollectionUtil.isNullEmptyFromString(accessToken)) {
            saveAccessToken(accessToken.toString());
          }
          state = Success(accessToken);
        } else {
          state = Failure(value.message);
        }
      },
    );
  }

  Future<void> saveAccessToken(String accessToken) async {
    await _postLoginAccessToken.call(accessToken);
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    Service.addHeader(key: HeaderKey.ApplicationTimeZone, value: timeZone);
    Service.addHeader(key: HeaderKey.Authorization, value: accessToken);
  }

  void init() => state = Idle();
}
