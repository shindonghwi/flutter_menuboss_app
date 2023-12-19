import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/media/ResponseMediaCreate.dart';
import 'package:menuboss/domain/repositories/remote/media/RemoteMediaRepository.dart';

class PostCreateMediaFolderUseCase {
  PostCreateMediaFolderUseCase();

  final RemoteMediaRepository _remoteMediaRepository = GetIt.instance<RemoteMediaRepository>();

  Future<ApiResponse<ResponseMediaCreate>> call() async {
    return await _remoteMediaRepository.postCreateMediaFolder();
  }
}
