import 'dart:async';

import '../../../../data/models/ApiResponse.dart';
import '../../../../data/models/me/ResponseMeInfoModel.dart';

abstract class RemoteMeRepository {
  /// 내 정보 요청
  Future<ApiResponse<ResponseMeInfoModel>> getMe();
}
