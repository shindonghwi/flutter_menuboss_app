import 'dart:async';

import 'package:menuboss/data/models/base/ApiListResponse.dart';

import '../../../../data/models/business/ResponseBusinessMemberModel.dart';

abstract class RemoteBusinessRepository {
  /// 구성원 목록 조회
  Future<ApiListResponse<List<ResponseBusinessMemberModel>>> getMembers();
}
