import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/data_source/remote/HeaderKey.dart';
import 'package:menuboss/data/data_source/remote/Service.dart';
import 'package:menuboss/data/models/me/RequestMeSocialJoinModel.dart';
import 'package:menuboss/data/models/me/ResponseMeInfoModel.dart';
import 'package:menuboss/domain/models/auth/LoginPlatform.dart';
import 'package:menuboss/domain/usecases/local/app/PostLoginAccessTokenUseCase.dart';
import 'package:menuboss/domain/usecases/remote/auth/PostAppleSignInUseCase.dart';
import 'package:menuboss/domain/usecases/remote/auth/PostEmailUseCase.dart';
import 'package:menuboss/domain/usecases/remote/auth/PostKakaoSignInUseCase.dart';
import 'package:menuboss/domain/usecases/remote/auth/PostSocialLoginUseCase.dart';
import 'package:menuboss/domain/usecases/remote/me/GetMeInfoUseCase.dart';
import 'package:menuboss/domain/usecases/remote/validation/PostValidationSocialLoginUseCase.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/UiState.dart';
import 'package:menuboss_common/utils/dto/Pair.dart';

final loginProvider = StateNotifierProvider<LoginUiStateNotifier, UIState<String?>>(
  (_) => LoginUiStateNotifier(),
);

class LoginUiStateNotifier extends StateNotifier<UIState<String?>> {
  LoginUiStateNotifier() : super(Idle<String?>());

  PostEmailLoginUseCase get _postEmailLoginInUseCase => GetIt.instance<PostEmailLoginUseCase>();

  PostSocialLoginInUseCase get _postSocialLoginInUseCase =>
      GetIt.instance<PostSocialLoginInUseCase>();

  PostValidationSocialLoginUseCase get _postValidationSocialLoginInUseCase =>
      GetIt.instance<PostValidationSocialLoginUseCase>();

  PostAppleSignInUseCase get _postAppleSignInUseCase => GetIt.instance<PostAppleSignInUseCase>();

  PostKakaoSignInUseCase get _postKakaoSignInUseCase => GetIt.instance<PostKakaoSignInUseCase>();

  PostLoginAccessTokenUseCase get _postLoginAccessToken =>
      GetIt.instance<PostLoginAccessTokenUseCase>();

  GetMeInfoUseCase get _getMeInfoUseCase => GetIt.instance<GetMeInfoUseCase>();
  ResponseMeInfoModel? meInfo;

  String _email = "";
  String _password = "";

  void updateEmail(String text) => _email = text;

  void updatePassword(String text) => _password = text;

  void doEmailLogin({String? email, String? password}) async {
    state = Loading();

    final result = await _postEmailLoginInUseCase.call(
      email: email ?? _email,
      password: password ?? _password,
    );

    if (result.status == 200) {
      final accessToken = result.data?.accessToken;
      if (!CollectionUtil.isNullEmptyFromString(accessToken)) {
        await saveAccessToken(accessToken.toString());
      }
      requestMeInfo();
    } else {
      state = Failure(result.message);
    }
  }

  Future<Pair<String?, RequestMeSocialJoinModel>?> doAppleLogin() async {
    state = Loading();
    final result = await _postAppleSignInUseCase.call();
    if (result.status == 200) {
      final accessToken = result.data?.accessToken;
      final email = result.data?.email;
      return await proceedSocialLogin(LoginPlatform.Apple, accessToken, email);
    } else {
      state = Failure(result.message);
    }
    return Future(() => null);
  }

  Future<Pair<String?, RequestMeSocialJoinModel>?> doKakaoLogin() async {
    state = Loading();
    final result = await _postKakaoSignInUseCase.call();
    if (result.status == 200) {
      final accessToken = result.data?.accessToken;
      final email = result.data?.email;
      return await proceedSocialLogin(LoginPlatform.Kakao, accessToken, email);
    } else {
      state = Failure(result.message);
    }
    return Future(() => null);
  }

  Future<Pair<String?, RequestMeSocialJoinModel>?> proceedSocialLogin(
    LoginPlatform platform,
    String? token,
    String? email,
  ) async {
    final res = await _postValidationSocialLoginInUseCase.call(
      platform,
      token ?? "",
    );

    if (res.status == 200) {
      final result = await _postSocialLoginInUseCase.call(
        platform: platform,
        accessToken: token ?? "",
      );

      if (result.status == 200) {
        final accessToken = result.data?.accessToken;
        if (!CollectionUtil.isNullEmptyFromString(accessToken)) {
          await saveAccessToken(accessToken.toString());
        }
        requestMeInfo();
      } else {
        state = Failure(result.message);
      }
    } else if (res.status == 404) {
      // 회원가입 필요
      state = Idle();
      return Future(
        () => Pair(email, RequestMeSocialJoinModel(type: platform.name, accessToken: "$token")),
      );
    } else {
      state = Failure(res.message);
    }

    return Future(() => null);
  }

  // 로그인 성공시, 사용자 정보 호출
  void requestMeInfo() {
    _getMeInfoUseCase.call().then(
      (value) {
        if (value.status == 200 && value.data != null) {
          meInfo = value.data;
          final accessToken = value.data?.authorization?.accessToken;

          // me 호출시 accessToken이 변경되었을 경우, Service에 변경된 accessToken을 적용
          if (Service.headers[HeaderKey.Authorization] != accessToken &&
              !CollectionUtil.isNullEmptyFromString(accessToken)) {
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
