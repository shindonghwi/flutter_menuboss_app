import 'dart:async';

import 'package:menuboss/data/models/auth/RequestEmailLoginModel.dart';
import 'package:menuboss/data/models/auth/RequestSocialLoginModel.dart';
import 'package:menuboss/domain/models/auth/SocialLoginModel.dart';

import '../../../../data/models/base/ApiResponse.dart';
import '../../../../data/models/auth/ResponseLoginModel.dart';

abstract class RemoteAuthRepository {
  /// 애플 로그인
  Future<ApiResponse<SocialLoginModel>> doAppleLogin();

  /// 구글 로그인
  Future<ApiResponse<SocialLoginModel>> doGoogleLogin();

  /// 소셜 로그인
  Future<ApiResponse<ResponseLoginModel>> postSocialLogin({
    required RequestSocialLoginModel requestSocialLoginModel,
  });

  /// 이메일 로그인
  Future<ApiResponse<ResponseLoginModel>> postEmailLogin({
    required RequestEmailLoginModel requestEmailLoginModel,
  });

  /// 로그아웃
  Future<ApiResponse<void>> postLogout();
}
