import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/app/env/Environment.dart';
import 'package:menuboss/data/data_source/remote/HeaderKey.dart';
import 'package:menuboss/data/models/auth/RequestEmailLoginModel.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/domain/models/auth/SocialLoginModel.dart';
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
          ? "https://dev-app-api-us.menuboss.live/v1/external/apple/callback"
          : "https://app-api.themenuboss.com/v1/external/apple/callback";
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
            message: "",
            data: SocialLoginModel(
              LoginPlatform.Apple,
              appleIdCredential.identityToken,
            ),
          );
        } else {
          return ApiResponse<SocialLoginModel>(
            status: 404,
            message: "User information not found",
            data: null,
          );
        }
      } catch (e) {
        debugPrint(
            "doAppleLogin: 500 : A temporary failure has occurred.\nPlease use a different login method");
        return ApiResponse<SocialLoginModel>(
          status: 500,
          message: "",
          data: null,
        );
      }
    } else {
      debugPrint("doGoogleLogin: 406 : The network connection is unstable");
      return ApiResponse<SocialLoginModel>(
        status: 406,
        message: "The network connection is unstable",
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
            message: "User information not found",
            data: null,
          );
        } else {
          // Google Auth Provider 를 통해 Credential 정보를 받아온다.
          final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

          debugPrint("doGoogleLogin accessToken: ${googleAuth.accessToken}");
          debugPrint("doGoogleLogin idToken: ${googleAuth.idToken}");

          if (CollectionUtil.isNullEmptyFromString(googleAuth.idToken)){
            return ApiResponse<SocialLoginModel>(
              status: 404,
              message: "User information not found",
              data: null,
            );
          }else{
            return await googleUser.authentication.then(
                  (value) {
                return ApiResponse<SocialLoginModel>(
                  status: 200,
                  message: "",
                  data: SocialLoginModel(
                    LoginPlatform.Google,
                    value.idToken,
                  ),
                );
              },
            );
          }
        }
      } catch (e) {
        debugPrint(
            "doAppleLogin: 500 : A temporary failure has occurred.\nPlease use a different login method");
        return ApiResponse<SocialLoginModel>(
          status: 500,
          message: "",
          data: null,
        );
      }
    } else {
      debugPrint("doGoogleLogin: 406 : The network connection is unstable");
      return ApiResponse<SocialLoginModel>(
        status: 406,
        message: "The network connection is unstable",
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
