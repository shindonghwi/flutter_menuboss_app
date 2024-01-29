import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/domain/repositories/remote/me/RemoteMeRepository.dart';

class PatchMePhoneUseCase {
  PatchMePhoneUseCase();

  final RemoteMeRepository _remoteMeRepository = GetIt.instance<RemoteMeRepository>();

  Future<ApiResponse<void>> call(String phone) async {
    return await _remoteMeRepository.patchPhone(phone);
  }
}
