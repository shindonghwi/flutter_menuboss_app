import 'package:get_it/get_it.dart';
import 'package:menuboss/data/data_source/remote/app/RemoteAppApi.dart';
import 'package:menuboss/data/models/app/ResponseAppCheckUpModel.dart';
import 'package:menuboss/data/models/auth/RequestEmailLoginModel.dart';
import 'package:menuboss/data/models/auth/RequestSocialLoginModel.dart';
import 'package:menuboss/data/models/auth/ResponseLoginModel.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/domain/models/auth/SocialLoginModel.dart';

import '../../../../domain/repositories/remote/app/RemoteAppRepository.dart';
import '../../../../domain/repositories/remote/auth/RemoteAuthRepository.dart';
import '../../../data_source/remote/auth/RemoteAuthApi.dart';

class RemoteAppRepositoryImpl implements RemoteAppRepository {
  RemoteAppRepositoryImpl();

  final RemoteAppApi _remoteAppApi = GetIt.instance<RemoteAppApi>();

  @override
  Future<ApiResponse<ResponseAppCheckUpModel>> checkApp() {
    return _remoteAppApi.checkApp();
  }
}
