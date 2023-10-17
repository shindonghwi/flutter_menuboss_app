import 'dart:async';

import 'package:menuboss/data/models/me/RequestMeJoinModel.dart';
import 'package:menuboss/data/models/me/ResponseMeAuthorization.dart';

import '../../../../data/models/base/ApiResponse.dart';
import '../../../../data/models/me/ResponseMeInfoModel.dart';

abstract class RemoteMeRepository {
  /// 내 정보 요청
  Future<ApiResponse<ResponseMeInfoModel>> getMe();

  /// Owner 이름 수정
  Future<ApiResponse<void>> patchName(String name);

  /// Owner 이름 수정
  Future<ApiResponse<ResponseMeAuthorization>> postJoin(RequestMeJoinModel model);
}
