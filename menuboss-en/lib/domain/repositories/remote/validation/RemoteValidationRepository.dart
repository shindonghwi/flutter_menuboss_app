import 'dart:async';

import 'package:menuboss/data/models/auth/RequestEmailLoginModel.dart';
import 'package:menuboss/data/models/auth/RequestSocialLoginModel.dart';
import 'package:menuboss/domain/models/auth/SocialLoginModel.dart';

import '../../../../data/models/base/ApiResponse.dart';
import '../../../../data/models/auth/ResponseLoginModel.dart';

abstract class RemoteValidationRepository {
  /// 소셜 로그인 체크
  Future<ApiResponse<void>> verifySocialLogin(String type, String accessToken);
}
