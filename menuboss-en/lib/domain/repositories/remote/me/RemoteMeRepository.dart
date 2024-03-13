import 'dart:async';

import 'package:menuboss/data/models/me/RequestMeJoinModel.dart';
import 'package:menuboss/data/models/me/RequestMeSocialJoinModel.dart';
import 'package:menuboss/data/models/me/ResponseMeAuthorization.dart';
import 'package:menuboss/data/models/me/ResponseMeUpdateProfile.dart';

import '../../../../data/models/base/ApiResponse.dart';
import '../../../../data/models/me/ResponseMeInfoModel.dart';

abstract class RemoteMeRepository {
  /// 내 정보 요청
  Future<ApiResponse<ResponseMeInfoModel>> getMe();

  /// Owner 이름 수정
  Future<ApiResponse<void>> patchName(String name);

  /// Owner 번호 수정
  Future<ApiResponse<void>> patchPhone(String country, String name);

  /// Owner 패스워드 수정
  Future<ApiResponse<void>> patchPassword(String password);

  /// 이메일 회원가입
  Future<ApiResponse<ResponseMeAuthorization>> postJoin(RequestMeJoinModel model);

  /// 소셜 회원가입
  Future<ApiResponse<ResponseMeAuthorization>> postSocialJoin(RequestMeSocialJoinModel model);

  /// 계정 삭제
  Future<ApiResponse<void>> postMeLeave(String? reason);

  /// 프로필 이미지 업데이트
  Future<ApiResponse<ResponseMeUpdateProfile>> patchProfileImage(int imageId);
}
