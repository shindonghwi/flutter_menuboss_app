import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/playlist/RequestPlaylistUpdateInfoModel.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';
import 'package:menuboss/domain/repositories/remote/playlist/RemotePlaylistRepository.dart';

class PostPlaylistUseCase {
  PostPlaylistUseCase();

  final RemotePlaylistRepository _remotePlaylistRepository = GetIt.instance<RemotePlaylistRepository>();

  Future<ApiResponse<ResponsePlaylistModel>> call(RequestPlaylistUpdateInfoModel data) async {
    return await _remotePlaylistRepository.postPlaylist(data);
  }
}
