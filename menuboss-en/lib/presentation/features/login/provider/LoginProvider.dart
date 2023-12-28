import 'package:flutter/cupertino.dart';
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
import 'package:menuboss/domain/usecases/remote/auth/PostGoogleSignInUseCase.dart';
import 'package:menuboss/domain/usecases/remote/me/GetMeInfoUseCase.dart';
import 'package:menuboss/domain/usecases/remote/validation/PostValidationSocialLoginUseCase.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/UiState.dart';

import '../../../../domain/usecases/remote/auth/PostSocialLoginUseCase.dart';

final loginProvider = StateNotifierProvider<LoginUiStateNotifier, UIState<String?>>(
  (_) => LoginUiStateNotifier(),
);

class LoginUiStateNotifier extends StateNotifier<UIState<String?>> {
  LoginUiStateNotifier() : super(Idle<String?>());

  PostEmailLoginUseCase get _postEmailLoginInUseCase => GetIt.instance<PostEmailLoginUseCase>();

  PostValidationSocialLoginUseCase get _postValidationSocialLoginInUseCase =>
      GetIt.instance<PostValidationSocialLoginUseCase>();

  PostAppleSignInUseCase get _postAppleSignInUseCase => GetIt.instance<PostAppleSignInUseCase>();

  PostGoogleSignInUseCase get _postGoogleSignInUseCase => GetIt.instance<PostGoogleSignInUseCase>();

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

  void doAppleLogin() async {
    state = Loading();
    final result = await _postAppleSignInUseCase.call();
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

  Future<RequestMeSocialJoinModel?> doGoogleLogin() async {
    state = Loading();
    final result = await _postGoogleSignInUseCase.call();
    if (result.status == 200) {
      final accessToken = result.data?.accessToken;
      return await proceedSocialLogin(LoginPlatform.Google, accessToken);
    } else {
      state = Failure(result.message);
    }
    return Future(() => null);
  }

  Future<RequestMeSocialJoinModel?> proceedSocialLogin(LoginPlatform platform, String? token) async {
    final res = await _postValidationSocialLoginInUseCase.call(
      platform,
      token ?? "",
    );

    if (res.status == 200) {
      // 로그인 가능
      if (!CollectionUtil.isNullEmptyFromString(token)) {
        await saveAccessToken(token.toString());
      }
      requestMeInfo();
    } else if (res.status == 404) {
      // 회원가입 필요
      state = Idle();
      return Future(() => RequestMeSocialJoinModel(type: platform.name, accessToken: "$token"));
    }else{
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
