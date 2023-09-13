import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/ApiResponse.dart';
import 'package:menuboss/data/models/playlist/RequestPlaylistUpdateInfoModel.dart';
import 'package:menuboss/domain/repositories/remote/playlist/RemotePlaylistRepository.dart';

class PatchPlaylistUseCase {
  PatchPlaylistUseCase();

  final RemotePlaylistRepository _remotePlaylistRepository = GetIt.instance<RemotePlaylistRepository>();

  Future<ApiResponse<void>> call(int playlistId, RequestPlaylistUpdateInfoModel data) async {
    return await _remotePlaylistRepository.patchPlaylist(playlistId, data);
  }
}
