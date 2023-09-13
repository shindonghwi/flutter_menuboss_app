import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/ApiResponse.dart';
import 'package:menuboss/domain/repositories/remote/playlist/RemotePlaylistRepository.dart';

class DelPlaylistUseCase {
  DelPlaylistUseCase();

  final RemotePlaylistRepository _remotePlaylistRepository = GetIt.instance<RemotePlaylistRepository>();

  Future<ApiResponse<void>> call(int playlistId) async {
    return await _remotePlaylistRepository.delPlaylist(playlistId);
  }
}
