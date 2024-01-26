import 'dart:async';

import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/business/RequestRoleModel.dart';
import 'package:menuboss/data/models/business/RequestTeamMemberModel.dart';
import 'package:menuboss/data/models/business/ResponseRoleModel.dart';

import '../../../../data/models/business/ResponseBusinessMemberModel.dart';

abstract class RemoteBusinessRepository {
  /// 구성원 목록 조회
  Future<ApiListResponse<List<ResponseBusinessMemberModel>>> getMembers();

  /// 구성원 등록
  Future<ApiResponse<void>> registerMember(RequestTeamMemberModel model);

  /// 구성원 수정
  Future<ApiResponse<void>> patchMember(RequestTeamMemberModel model, int memberId);

  /// 역할 목록 조회
  Future<ApiListResponse<List<ResponseRoleModel>>> getRoles();

  /// 역할 등록
  Future<ApiResponse<void>> registerRole(RequestRoleModel model);

  /// 역할 수정
  Future<ApiResponse<void>> patchRole(RequestRoleModel model, int roleId);
}
