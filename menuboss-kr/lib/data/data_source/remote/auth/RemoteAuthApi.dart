import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/app/env/Environment.dart';
import 'package:menuboss/data/data_source/remote/HeaderKey.dart';
import 'package:menuboss/data/models/auth/RequestEmailLoginModel.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/domain/models/auth/SocialLoginModel.dart';
import 'package:menuboss_common/ui/strings.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../domain/models/auth/LoginPlatform.dart';
import '../../../models/auth/RequestSocialLoginModel.dart';
import '../../../models/auth/ResponseLoginModel.dart';
import '../BaseApiUtil.dart';
import '../Service.dart';

class RemoteAuthApi {
  RemoteAuthApi();

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// @feature: 애플 로그인
  /// @author: 2023/09/11 6:31 PM donghwishin
  Future<ApiResponse<SocialLoginModel>> doAppleLogin() async {
    if (await Service.isNetworkAvailable()) {
      final rawNonce = generateNonce();

      final packageInfo = await PackageInfo.fromPlatform();

      final redirectURL = Environment.buildType == BuildType.dev
          ? "https://dev-app-api.menuboss.kr/v1/external/apple/callback"
          : "https://app-api.menuboss.kr/v1/external/apple/callback";
      final clientID = packageInfo.packageName.split(".").reversed.join(".");

      debugPrint("redirectURL: $redirectURL");
      debugPrint("clientID: $clientID");

      final nonce = _sha256ofString(rawNonce);
      try {
        final appleIdCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          webAuthenticationOptions: WebAuthenticationOptions(
            clientId: clientID,
            redirectUri: Uri.parse(redirectURL),
          ),
          nonce: nonce,
        );

        if (!CollectionUtil.isNullEmptyFromString(appleIdCredential.identityToken)) {
          return ApiResponse<SocialLoginModel>(
            status: 200,
            message:
            Strings.of(MenuBossGlobalVariable.navigatorKey.currentContext).messageApiSuccess,
            data: SocialLoginModel(
              LoginPlatform.Apple,
              appleIdCredential.identityToken,
            ),
          );
        } else {
          return ApiResponse<SocialLoginModel>(
            status: 404,
            message:
            Strings.of(MenuBossGlobalVariable.navigatorKey.currentContext).messageNotFoundUser,
            data: null,
          );
        }
      } catch (e) {
        debugPrint(
            "doAppleLogin: 400 :${Strings.of(MenuBossGlobalVariable.navigatorKey.currentContext).messageTempLoginFail} ${e.toString()}");
        return ApiResponse<SocialLoginModel>(
          status: 400,
          message: "",
          data: null,
        );
      }
    } else {
      debugPrint(
          "doAppleLogin: 406 :${Strings.of(MenuBossGlobalVariable.navigatorKey.currentContext).messageNetworkRequired} ${e}");
      return ApiResponse<SocialLoginModel>(
        status: 406,
        message:
            Strings.of(MenuBossGlobalVariable.navigatorKey.currentContext).messageNetworkRequired,
        data: null,
      );
    }
  }

  /// @feature: 구글 로그인
  /// @author: 2023/09/11 6:31 PM donghwishin
  Future<ApiResponse<SocialLoginModel>> doGoogleLogin() async {
    await GoogleSignIn().signOut();
    if (await Service.isNetworkAvailable()) {
      try {
        // 구글 로그인 후 유저정보를 받아온다.
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) {
          return ApiResponse<SocialLoginModel>(
            status: 404,
            message:
                Strings.of(MenuBossGlobalVariable.navigatorKey.currentContext).messageNotFoundUser,
            data: null,
          );
        } else {
          // Google Auth Provider 를 통해 Credential 정보를 받아온다.
          final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
          final OAuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          debugPrint("doGoogleLogin accessToken: ${googleAuth.accessToken}");
          debugPrint("doGoogleLogin idToken: ${googleAuth.idToken}");

          // 위에서 가져온 Credential 정보로 Firebase에 사용자 인증을한다.
          final UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
          final User? user = userCredential.user;

          if (user != null) {
            return await googleUser.authentication.then(
              (value) {
                return ApiResponse<SocialLoginModel>(
                  status: 200,
                  message: Strings.of(MenuBossGlobalVariable.navigatorKey.currentContext)
                      .messageApiSuccess,
                  data: SocialLoginModel(
                    LoginPlatform.Google,
                    value.idToken,
                  ),
                );
              },
            );
          } else {
            return ApiResponse<SocialLoginModel>(
              status: 404,
              message: Strings.of(MenuBossGlobalVariable.navigatorKey.currentContext)
                  .messageNotFoundUser,
              data: null,
            );
          }
        }
      } catch (e) {
        debugPrint(
            "doGoogleLogin: 500 :${Strings.of(MenuBossGlobalVariable.navigatorKey.currentContext).messageTempLoginFail} ${e.toString()}");
        return ApiResponse<SocialLoginModel>(
          status: 500,
          message:
              Strings.of(MenuBossGlobalVariable.navigatorKey.currentContext).messageTempLoginFail,
          data: null,
        );
      }
    } else {
      debugPrint(
          "doGoogleLogin: 406 :${Strings.of(MenuBossGlobalVariable.navigatorKey.currentContext).messageNetworkRequired} ${e}");
      return ApiResponse<SocialLoginModel>(
        status: 406,
        message:
            Strings.of(MenuBossGlobalVariable.navigatorKey.currentContext).messageNetworkRequired,
        data: null,
      );
    }
  }

  /// @feature: 카카오 로그인
  /// @author: 2023/09/11 6:31 PM donghwishin
  Future<ApiResponse<SocialLoginModel>> doKakaoLogin() async {
    ApiResponse<SocialLoginModel> successKakaoLogin(String idToken) {
      return ApiResponse<SocialLoginModel>(
        status: 200,
        message: Strings.of(MenuBossGlobalVariable.navigatorKey.currentContext).messageApiSuccess,
        data: SocialLoginModel(
          LoginPlatform.Kakao,
          idToken,
        ),
      );
    }

    ApiResponse<SocialLoginModel> failureKakaoLogin(String message) {
      return ApiResponse<SocialLoginModel>(
        status: 404,
        message: message,
        data: null,
      );
    }

    if (await Service.isNetworkAvailable()) {
      try {
        if (await kakao.isKakaoTalkInstalled()) {
          try {
            final res = await kakao.UserApi.instance.loginWithKakaoTalk();
            return successKakaoLogin(res.accessToken.toString());
          } catch (error) {
            // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
            // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
            if (error is PlatformException && error.code == 'CANCELED') {
              // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
              return failureKakaoLogin('');
            }
            try {
              final res = await kakao.UserApi.instance.loginWithKakaoAccount();
              return successKakaoLogin(res.accessToken.toString());
            } catch (error) {
              return failureKakaoLogin(
                Strings.of(MenuBossGlobalVariable.navigatorKey.currentContext).messageNotFoundUser,
              );
            }
          }
        } else {
          try {
            final res = await kakao.UserApi.instance.loginWithKakaoAccount();
            return successKakaoLogin(res.accessToken.toString());
          } catch (error) {
            return failureKakaoLogin(
              Strings.of(MenuBossGlobalVariable.navigatorKey.currentContext).messageNotFoundUser,
            );
          }
        }
      } catch (e) {
        debugPrint(
            "doKakaoLogin: 500 :${Strings.of(MenuBossGlobalVariable.navigatorKey.currentContext).messageTempLoginFail} ${e.toString()}");
        return ApiResponse<SocialLoginModel>(
          status: 500,
          message:
              Strings.of(MenuBossGlobalVariable.navigatorKey.currentContext).messageTempLoginFail,
          data: null,
        );
      }
    } else {
      debugPrint(
          "doKakaoLogin: 406 :${Strings.of(MenuBossGlobalVariable.navigatorKey.currentContext).messageNetworkRequired} ${e}");
      return ApiResponse<SocialLoginModel>(
        status: 406,
        message:
            Strings.of(MenuBossGlobalVariable.navigatorKey.currentContext).messageNetworkRequired,
        data: null,
      );
    }
  }

  /// @feature: API 소셜 로그인 (구글, 애플)
  /// @author: 2023/09/11 6:31 PM donghwishin
  Future<ApiResponse<ResponseLoginModel>> postSocialLogin({
    required RequestSocialLoginModel requestSocialLoginModel,
  }) async {
    try {
      Service.addHeader(key: HeaderKey.Authorization, value: "");
      final response = await Service.postApi(
        type: ServiceType.Auth,
        endPoint: 'social/login',
        jsonBody: requestSocialLoginModel.toJson(),
      );

      final errorResponse = BaseApiUtil.isErrorStatusCode(response);
      if (errorResponse != null) {
        return BaseApiUtil.errorResponse(
          status: errorResponse.status,
          message: errorResponse.message,
        );
      } else {
        return ApiResponse.fromJson(
          jsonDecode(response.body),
          (json) => ResponseLoginModel.fromJson(json),
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// @feature: API 이메일 로그인
  /// @author: 2023/09/11 6:31 PM donghwishin
  Future<ApiResponse<ResponseLoginModel>> postEmailLogin({
    required RequestEmailLoginModel requestEmailLoginModel,
  }) async {
    try {
      Service.addHeader(key: HeaderKey.Authorization, value: "");
      final response = await Service.postApi(
        type: ServiceType.Auth,
        endPoint: 'login',
        jsonBody: requestEmailLoginModel.toJson(),
      );

      final errorResponse = BaseApiUtil.isErrorStatusCode(response);
      if (errorResponse != null) {
        return BaseApiUtil.errorResponse(
          status: errorResponse.status,
          message: errorResponse.message,
        );
      } else {
        return ApiResponse.fromJson(
          jsonDecode(response.body),
          (json) => ResponseLoginModel.fromJson(json),
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// @feature: API 로그아웃
  /// @author: 2023/09/11 6:31 PM donghwishin
  Future<ApiResponse<ResponseLoginModel>> postLogout() async {
    try {
      final response = await Service.postApi(
        type: ServiceType.Auth,
        endPoint: 'logout',
        jsonBody: null,
      );

      final errorResponse = BaseApiUtil.isErrorStatusCode(response);
      if (errorResponse != null) {
        return BaseApiUtil.errorResponse(
          status: errorResponse.status,
          message: errorResponse.message,
        );
      } else {
        return ApiResponse.fromJson(
          jsonDecode(response.body),
          (json) => ResponseLoginModel.fromJson(json),
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }
}
