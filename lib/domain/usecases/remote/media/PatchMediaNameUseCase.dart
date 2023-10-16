import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/domain/repositories/remote/media/RemoteMediaRepository.dart';

class PatchMediaNameUseCase {
  PatchMediaNameUseCase();

  final RemoteMediaRepository _remoteMediaRepository = GetIt.instance<RemoteMediaRepository>();

  Future<ApiResponse<void>> call(String mediaId, String name) async {
    return await _remoteMediaRepository.patchMediaName(mediaId, name);
  }
}
