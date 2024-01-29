import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/business/ResponseBusinessMemberModel.dart';
import 'package:menuboss/domain/repositories/remote/business/RemoteBusinessRepository.dart';

import '../../../../data/models/business/ResponseRoleModel.dart';

class GetRolesUseCase {
  GetRolesUseCase();

  final RemoteBusinessRepository _remoteBusinessRepository =
      GetIt.instance<RemoteBusinessRepository>();

  Future<ApiListResponse<List<ResponseRoleModel>>> call() async {
    return await _remoteBusinessRepository.getRoles();
  }
}
