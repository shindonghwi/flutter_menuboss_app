import 'dart:async';

import 'package:menuboss/data/models/app/ResponseAppCheckUpModel.dart';
import 'package:menuboss/data/models/auth/RequestEmailLoginModel.dart';
import 'package:menuboss/data/models/auth/RequestSocialLoginModel.dart';
import 'package:menuboss/domain/models/auth/SocialLoginModel.dart';

import '../../../../data/models/base/ApiResponse.dart';
import '../../../../data/models/auth/ResponseLoginModel.dart';

abstract class RemoteAppRepository {
  /// 앱 버전 체크
  Future<ApiResponse<ResponseAppCheckUpModel>> checkApp();

}
