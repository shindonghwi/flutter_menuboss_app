import 'dart:convert';

import 'package:menuboss/data/models/base/ApiListResponse.dart';

import '../../../models/business/ResponseBusinessMemberModel.dart';
import '../BaseApiUtil.dart';
import '../Service.dart';

class RemoteBusinessApi {
  RemoteBusinessApi();

  /// 멤버목록 요청
  Future<ApiListResponse<List<ResponseBusinessMemberModel>>> getMembers() async {
    try {
      final response = await Service.getApi(
        type: ServiceType.Business,
        endPoint: "members?page=1&size=150",
      );

      final errorResponse = BaseApiUtil.isErrorStatusCode(response);
      if (errorResponse != null) {
        return BaseApiUtil.errorListResponse(
          status: errorResponse.status,
          message: errorResponse.message,
        );
      } else {
        return ApiListResponse.fromJson(
          jsonDecode(response.body),
          (json) {
            return List<ResponseBusinessMemberModel>.from(
              json.map(
                (item) => ResponseBusinessMemberModel.fromJson(item as Map<String, dynamic>),
              ),
            );
          },
        );
      }
    } catch (e) {
      return BaseApiUtil.errorListResponse(
        message: e.toString(),
      );
    }
  }
}
