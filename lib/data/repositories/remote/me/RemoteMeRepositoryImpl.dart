import 'package:get_it/get_it.dart';

import '../../../../domain/repositories/remote/me/RemoteMeRepository.dart';
import '../../../data_source/remote/me/RemoteMeApi.dart';
import '../../../models/ApiResponse.dart';
import '../../../models/me/ResponseMeInfoModel.dart';

class RemoteMeRepositoryImpl implements RemoteMeRepository {
  RemoteMeRepositoryImpl();

  @override
  Future<ApiResponse<ResponseMeInfoModel>> getMe() {
    RemoteMeApi remoteMeApi = GetIt.instance<RemoteMeApi>();
    return remoteMeApi.getMe();
  }

  @override
  Future<ApiResponse<void>> patchName(String name) {
    RemoteMeApi remoteMeApi = GetIt.instance<RemoteMeApi>();
    return remoteMeApi.patchName(name);
  }
}
