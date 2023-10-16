import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/domain/repositories/remote/media/RemoteMediaRepository.dart';

class DelMediaUseCase {
  DelMediaUseCase();

  final RemoteMediaRepository _remoteMediaRepository = GetIt.instance<RemoteMediaRepository>();

  Future<ApiResponse<void>> call(List<String> mediaIds) async {
    return await _remoteMediaRepository.delMedia(mediaIds);
  }
}
