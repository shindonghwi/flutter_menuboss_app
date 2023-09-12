import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/data/models/ApiResponse.dart';
import 'package:menuboss/data/models/auth/RequestEmailLoginModel.dart';
import 'package:menuboss/domain/models/auth/SocialLoginModel.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../domain/models/auth/LoginPlatform.dart';
import '../../../models/auth/RequestSocialLoginModel.dart';
import '../../../models/auth/ResponseLoginModel.dart';
import '../../../models/me/ResponseMeInfoModel.dart';
import '../BaseApiUtil.dart';
import '../Service.dart';

class RemoteMeApi {
  RemoteMeApi();

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  /// 내 정보 요청
  Future<ApiResponse<ResponseMeInfoModel>> getMe() async {
    final response = await Service.getApi(
      type: ServiceType.Me,
      endPoint: null,
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
            (json) => ResponseMeInfoModel.fromJson(json),
      );
    }
  }

}
