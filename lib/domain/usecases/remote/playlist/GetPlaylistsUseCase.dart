import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/ApiListResponse.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';
import 'package:menuboss/domain/repositories/remote/playlist/RemotePlaylistRepository.dart';

class GetPlaylistsUseCase {
  GetPlaylistsUseCase();

  final RemotePlaylistRepository _remotePlaylistRepository = GetIt.instance<RemotePlaylistRepository>();

  Future<ApiListResponse<List<ResponsePlaylistModel>>> call() async {
    return await _remotePlaylistRepository.getPlaylists();
  }
}
