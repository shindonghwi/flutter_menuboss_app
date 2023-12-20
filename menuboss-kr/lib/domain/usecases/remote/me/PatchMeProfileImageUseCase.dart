import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/me/ResponseMeUpdateProfile.dart';
import 'package:menuboss/domain/repositories/remote/me/RemoteMeRepository.dart';

class PatchMeProfileImageUseCase {
  PatchMeProfileImageUseCase();

  final RemoteMeRepository _remoteMeRepository = GetIt.instance<RemoteMeRepository>();

  Future<ApiResponse<ResponseMeUpdateProfile>> call(int imageId) async {
    return await _remoteMeRepository.patchProfileImage(imageId);
  }
}
