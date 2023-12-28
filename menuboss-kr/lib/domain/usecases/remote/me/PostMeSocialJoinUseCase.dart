import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/me/RequestMeJoinModel.dart';
import 'package:menuboss/data/models/me/ResponseMeAuthorization.dart';
import 'package:menuboss/data/models/me/ResponseMeInfoModel.dart';
import 'package:menuboss/domain/repositories/remote/me/RemoteMeRepository.dart';

import '../../../../data/models/me/RequestMeSocialJoinModel.dart';

class PostMeSocialJoinUseCase {
  PostMeSocialJoinUseCase();

  final RemoteMeRepository _remoteMeRepository = GetIt.instance<RemoteMeRepository>();

  Future<ApiResponse<ResponseMeAuthorization>> call(RequestMeSocialJoinModel model) async {
    return await _remoteMeRepository.postSocialJoin(model);
  }
}
