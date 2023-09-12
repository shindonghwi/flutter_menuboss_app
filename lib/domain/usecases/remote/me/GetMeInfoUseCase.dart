import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/ApiResponse.dart';
import 'package:menuboss/data/models/me/ResponseMeInfoModel.dart';
import 'package:menuboss/domain/repositories/remote/me/RemoteMeRepository.dart';

class GetMeInfoUseCase {
  GetMeInfoUseCase();

  final RemoteMeRepository _remoteMeRepository = GetIt.instance<RemoteMeRepository>();

  Future<ApiResponse<ResponseMeInfoModel>> call() async {
    final meInfo = await _remoteMeRepository.getMe();
    return meInfo;
  }
}
