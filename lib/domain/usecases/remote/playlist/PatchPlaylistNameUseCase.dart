import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/domain/repositories/remote/playlist/RemotePlaylistRepository.dart';

class PatchPlaylistNameUseCase {
  PatchPlaylistNameUseCase();

  final RemotePlaylistRepository _remotePlaylistRepository = GetIt.instance<RemotePlaylistRepository>();

  Future<ApiResponse<void>> call(int playlistId, String name) async {
    return await _remotePlaylistRepository.patchPlaylistName(playlistId, name);
  }
}
