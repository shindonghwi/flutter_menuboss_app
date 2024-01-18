import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/me/RequestMeJoinModel.dart';
import 'package:menuboss/data/models/me/RequestMeSocialJoinModel.dart';
import 'package:menuboss/data/models/me/ResponseMeAuthorization.dart';
import 'package:menuboss/data/models/me/ResponseMeUpdateProfile.dart';

import '../../../../domain/repositories/remote/me/RemoteMeRepository.dart';
import '../../../data_source/remote/me/RemoteMeApi.dart';
import '../../../models/base/ApiResponse.dart';
import '../../../models/me/ResponseMeInfoModel.dart';

class RemoteMeRepositoryImpl implements RemoteMeRepository {
  RemoteMeRepositoryImpl();

  RemoteMeApi remoteMeApi = GetIt.instance<RemoteMeApi>();

  @override
  Future<ApiResponse<ResponseMeInfoModel>> getMe() {
    return remoteMeApi.getMe();
  }

  @override
  Future<ApiResponse<void>> patchName(String name) {
    return remoteMeApi.patchName(name);
  }

  @override
  Future<ApiResponse<void>> patchPhone(String name) {
    return remoteMeApi.patchPhone(name);
  }

  @override
  Future<ApiResponse<void>> patchPassword(String password) {
    return remoteMeApi.patchPassword(password);
  }

  @override
  Future<ApiResponse<ResponseMeAuthorization>> postJoin(RequestMeJoinModel model) {
    return remoteMeApi.postJoin(model);
  }
  @override
  Future<ApiResponse<ResponseMeAuthorization>> postSocialJoin(RequestMeSocialJoinModel model) {
    return remoteMeApi.postSocialJoin(model);
  }

  @override
  Future<ApiResponse<void>> postMeLeave(String? reason) {
    return remoteMeApi.postMeLeave(reason);

  }

  @override
  Future<ApiResponse<ResponseMeUpdateProfile>> patchProfileImage(int imageId) {
    return remoteMeApi.patchProfileImage(imageId);
  }
}
