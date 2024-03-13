import 'dart:convert';

import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/business/RequestTeamMemberModel.dart';

import '../../../models/base/ApiResponse.dart';
import '../../../models/business/RequestAddressModel.dart';
import '../../../models/business/RequestRoleModel.dart';
import '../../../models/business/ResponseBusinessMemberModel.dart';
import '../../../models/business/ResponseRoleModel.dart';
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

  /// 역할목록 요청
  Future<ApiListResponse<List<ResponseRoleModel>>> getRoles() async {
    try {
      final response = await Service.getApi(
        type: ServiceType.Business,
        endPoint: "roles?page=1&size=150",
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
            return List<ResponseRoleModel>.from(
              json.map(
                (item) => ResponseRoleModel.fromJson(item as Map<String, dynamic>),
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

  /// 구성원 계정 생성
  Future<ApiResponse<void>> registerMember(RequestTeamMemberModel model) async {
    try {
      final response = await Service.postApi(
        type: ServiceType.Business,
        endPoint: "members",
        jsonBody: model.toJson(),
      );

      final errorResponse = BaseApiUtil.isErrorStatusCode(response);
      if (errorResponse != null) {
        return BaseApiUtil.errorResponse(
          status: errorResponse.status,
          message: errorResponse.message,
        );
      } else {
        return ApiResponse.fromJson(
          jsonDecode(response.body),
          (json) {},
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// 구성원 계정 수정
  Future<ApiResponse<void>> patchMember(RequestTeamMemberModel model, int memberId) async {
    try {
      final response = await Service.patchApi(
        type: ServiceType.Business,
        endPoint: "members/$memberId",
        jsonBody: model.toJson(),
      );

      final errorResponse = BaseApiUtil.isErrorStatusCode(response);
      if (errorResponse != null) {
        return BaseApiUtil.errorResponse(
          status: errorResponse.status,
          message: errorResponse.message,
        );
      } else {
        return ApiResponse.fromJson(
          jsonDecode(response.body),
          (json) {},
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// 역할 생성
  Future<ApiResponse<void>> registerRole(RequestRoleModel model) async {
    try {
      final response = await Service.postApi(
        type: ServiceType.Business,
        endPoint: "roles",
        jsonBody: model.toJson(),
      );

      final errorResponse = BaseApiUtil.isErrorStatusCode(response);
      if (errorResponse != null) {
        return BaseApiUtil.errorResponse(
          status: errorResponse.status,
          message: errorResponse.message,
        );
      } else {
        return ApiResponse.fromJson(
          jsonDecode(response.body),
          (json) {},
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// 역할 수정
  Future<ApiResponse<void>> patchRole(RequestRoleModel model, int roleId) async {
    try {
      final response = await Service.patchApi(
        type: ServiceType.Business,
        endPoint: "roles/$roleId",
        jsonBody: model.toJson(),
      );

      final errorResponse = BaseApiUtil.isErrorStatusCode(response);
      if (errorResponse != null) {
        return BaseApiUtil.errorResponse(
          status: errorResponse.status,
          message: errorResponse.message,
        );
      } else {
        return ApiResponse.fromJson(
          jsonDecode(response.body),
          (json) {},
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// 구성원 삭제
  Future<ApiResponse<void>> delMember(int memberId) async {
    try {
      final response = await Service.deleteApi(
        type: ServiceType.Business,
        endPoint: "members/$memberId",
        jsonBody: null,
      );

      final errorResponse = BaseApiUtil.isErrorStatusCode(response);
      if (errorResponse != null) {
        return BaseApiUtil.errorResponse(
          status: errorResponse.status,
          message: errorResponse.message,
        );
      } else {
        return ApiResponse.fromJson(
          jsonDecode(response.body),
          (json) {},
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// 역할 수정
  Future<ApiResponse<void>> delRole(int roleId) async {
    try {
      final response = await Service.deleteApi(
        type: ServiceType.Business,
        endPoint: "roles/$roleId",
        jsonBody: null,
      );

      final errorResponse = BaseApiUtil.isErrorStatusCode(response);
      if (errorResponse != null) {
        return BaseApiUtil.errorResponse(
          status: errorResponse.status,
          message: errorResponse.message,
        );
      } else {
        return ApiResponse.fromJson(
          jsonDecode(response.body),
          (json) {},
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// 이름 수정
  Future<ApiResponse<void>> patchName(String title) async {
    try {
      final response = await Service.patchApi(
        type: ServiceType.Business,
        endPoint: "title",
        jsonBody: {"title": title},
      );

      final errorResponse = BaseApiUtil.isErrorStatusCode(response);
      if (errorResponse != null) {
        return BaseApiUtil.errorResponse(
          status: errorResponse.status,
          message: errorResponse.message,
        );
      } else {
        return ApiResponse.fromJson(
          jsonDecode(response.body),
          (json) {},
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// 주소, 휴대폰 번호 수정
  Future<ApiResponse<void>> patchAddress(RequestAddressModel model) async {
    try {
      final response = await Service.patchApi(
        type: ServiceType.Business,
        endPoint: "address",
        jsonBody: model.toJson(),
      );

      final errorResponse = BaseApiUtil.isErrorStatusCode(response);
      if (errorResponse != null) {
        return BaseApiUtil.errorResponse(
          status: errorResponse.status,
          message: errorResponse.message,
        );
      } else {
        return ApiResponse.fromJson(
          jsonDecode(response.body),
          (json) {},
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }
}
