import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/domain/repositories/remote/media/RemoteMediaRepository.dart';

class PostMediaMoveUseCase {
  PostMediaMoveUseCase();

  final RemoteMediaRepository _remoteMediaRepository = GetIt.instance<RemoteMediaRepository>();

  Future<ApiResponse<void>> call(List<String> mediaIds, {String? folderId}) async {
    return await _remoteMediaRepository.postMediaMove(mediaIds, folderId: folderId);
  }
}
