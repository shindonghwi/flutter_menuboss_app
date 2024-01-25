import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/domain/repositories/remote/business/RemoteBusinessRepository.dart';

import '../../../data_source/remote/business/RemoteBusinessApi.dart';
import '../../../data_source/remote/me/RemoteMeApi.dart';
import '../../../models/business/ResponseBusinessMemberModel.dart';
import '../../../models/me/ResponseMeInfoModel.dart';

class RemoteBusinessRepositoryImpl implements RemoteBusinessRepository {
  RemoteBusinessRepositoryImpl();

  RemoteBusinessApi remoteBusinessApi = GetIt.instance<RemoteBusinessApi>();

  @override
  Future<ApiListResponse<List<ResponseBusinessMemberModel>>> getMembers() {
    return remoteBusinessApi.getMembers();
  }
}
