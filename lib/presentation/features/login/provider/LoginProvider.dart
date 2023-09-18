import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/data_source/remote/HeaderKey.dart';
import 'package:menuboss/data/data_source/remote/Service.dart';
import 'package:menuboss/data/models/me/ResponseMeInfoModel.dart';
import 'package:menuboss/domain/usecases/local/app/PostLoginAccessTokenUseCase.dart';
import 'package:menuboss/domain/usecases/remote/auth/PostEmailUseCase.dart';
import 'package:menuboss/domain/usecases/remote/me/GetMeInfoUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';

final LoginProvider = StateNotifierProvider<LoginUiStateNotifier, UIState<String?>>(
  (_) => LoginUiStateNotifier(),
);

class LoginUiStateNotifier extends StateNotifier<UIState<String?>> {
  LoginUiStateNotifier() : super(Idle<String?>());

  PostEmailLoginUseCase get _postEmailLoginInUseCase => GetIt.instance<PostEmailLoginUseCase>();

  PostLoginAccessTokenUseCase get _postLoginAccessToken => GetIt.instance<PostLoginAccessTokenUseCase>();

  GetMeInfoUseCase get _getMeInfoUseCase => GetIt.instance<GetMeInfoUseCase>();
  ResponseMeInfoModel? meInfo;

  String _email = "";
  String _password = "";

  void updateEmail(String text) => _email = text;

  void updatePassword(String text) => _password = text;

  void doEmailLogin() async {
    state = Loading();

    final result = await _postEmailLoginInUseCase.call(email: _email, password: _password);

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
    Service.addHeader(key: HeaderKey.TimeZone, value: timeZone);
    Service.addHeader(key: HeaderKey.Authorization, value: accessToken);
  }

  void init() => state = Idle();
}
