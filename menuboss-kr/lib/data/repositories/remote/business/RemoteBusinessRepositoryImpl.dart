import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/business/RequestRoleModel.dart';
import 'package:menuboss/data/models/business/RequestTeamMemberModel.dart';
import 'package:menuboss/domain/repositories/remote/business/RemoteBusinessRepository.dart';

import '../../../data_source/remote/business/RemoteBusinessApi.dart';
import '../../../models/business/ResponseBusinessMemberModel.dart';
import '../../../models/business/ResponseRoleModel.dart';

class RemoteBusinessRepositoryImpl implements RemoteBusinessRepository {
  RemoteBusinessRepositoryImpl();

  RemoteBusinessApi remoteBusinessApi = GetIt.instance<RemoteBusinessApi>();

  @override
  Future<ApiListResponse<List<ResponseBusinessMemberModel>>> getMembers() {
    return remoteBusinessApi.getMembers();
  }

  @override
  Future<ApiListResponse<List<ResponseRoleModel>>> getRoles() {
    return remoteBusinessApi.getRoles();
  }

  @override
  Future<ApiResponse<void>> registerMember(RequestTeamMemberModel model) {
    return remoteBusinessApi.registerMember(model);
  }

  @override
  Future<ApiResponse<void>> patchMember(RequestTeamMemberModel model, int memberId) {
    return remoteBusinessApi.patchMember(model, memberId);
  }

  @override
  Future<ApiResponse<void>> patchRole(RequestRoleModel model, int roleId) {
    return remoteBusinessApi.patchRole(model, roleId);
  }

  @override
  Future<ApiResponse<void>> registerRole(RequestRoleModel model) {
    return remoteBusinessApi.registerRole(model);
  }

  @override
  Future<ApiResponse<void>> delMember(int memberId) {
    return remoteBusinessApi.delMember(memberId);
  }

  @override
  Future<ApiResponse<void>> delRole(int roleId) {
    return remoteBusinessApi.delRole(roleId);
  }
}
