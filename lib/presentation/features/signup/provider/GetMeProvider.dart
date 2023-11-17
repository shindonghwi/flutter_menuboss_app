import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/data_source/remote/HeaderKey.dart';
import 'package:menuboss/data/data_source/remote/Service.dart';
import 'package:menuboss/data/models/me/ResponseMeInfoModel.dart';
import 'package:menuboss/domain/usecases/local/app/PostLoginAccessTokenUseCase.dart';
import 'package:menuboss/domain/usecases/remote/me/GetMeInfoUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';

final getMeProvider = StateNotifierProvider<GetMeNotifier, UIState<String?>>(
  (_) => GetMeNotifier(),
);

class GetMeNotifier extends StateNotifier<UIState<String?>> {
  GetMeNotifier() : super(Idle<String?>());

  GetMeInfoUseCase get _getMeInfoUseCase => GetIt.instance<GetMeInfoUseCase>();

  PostLoginAccessTokenUseCase get _postLoginAccessToken => GetIt.instance<PostLoginAccessTokenUseCase>();

  ResponseMeInfoModel? meInfo;

  // 로그인 성공시, 사용자 정보 호출
  void requestMeInfo() async {
    state = Loading();
    await Future.delayed(const Duration(seconds: 1));
    _getMeInfoUseCase.call().then(
      (value) async {
        if (value.status == 200 && value.data != null) {
          meInfo = value.data;
          final accessToken = value.data?.authorization?.accessToken;

          // me 호출시 accessToken이 변경되었을 경우, Service에 변경된 accessToken을 적용
          if (!CollectionUtil.isNullEmptyFromString(accessToken)) {
            await saveAccessToken(accessToken.toString());
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
