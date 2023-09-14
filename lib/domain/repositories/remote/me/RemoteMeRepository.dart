import 'dart:async';

import '../../../../data/models/base/ApiResponse.dart';
import '../../../../data/models/me/ResponseMeInfoModel.dart';

abstract class RemoteMeRepository {
  /// 내 정보 요청
  Future<ApiResponse<ResponseMeInfoModel>> getMe();

  /// Owner 이름 수정
  Future<ApiResponse<void>> patchName(String name);
}
