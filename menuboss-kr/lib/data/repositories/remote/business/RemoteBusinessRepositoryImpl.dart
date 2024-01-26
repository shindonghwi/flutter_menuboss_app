import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiListResponse.dart';
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
}
