import 'package:get_it/get_it.dart';
import 'package:menuboss/data/data_source/remote/playlist/RemotePlaylistApi.dart';
import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/playlist/RequestPlaylistUpdateInfoModel.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';

import '../../../../domain/repositories/remote/playlist/RemotePlaylistRepository.dart';
import '../../../models/base/ApiResponse.dart';
import '../../../models/playlist/ResponsePlaylistCreate.dart';
import '../../../models/playlist/ResponsePlaylistsModel.dart';

class RemotePlaylistRepositoryImpl implements RemotePlaylistRepository {
  RemotePlaylistRepositoryImpl();

  final RemotePlaylistApi _remotePlaylistApi = GetIt.instance<RemotePlaylistApi>();

  @override
  Future<ApiListResponse<List<ResponsePlaylistsModel>>> getPlaylists() {
    return _remotePlaylistApi.getPlaylists();
  }

  @override
  Future<ApiResponse<ResponsePlaylistModel>> getPlaylist(int playlistId) {
    return _remotePlaylistApi.getPlaylist(playlistId);
  }

  @override
  Future<ApiResponse<ResponsePlaylistCreate>> postPlaylist(RequestPlaylistUpdateInfoModel data) {
    return _remotePlaylistApi.postPlaylist(data);
  }

  @override
  Future<ApiResponse<void>> patchPlaylist(int playlistId, RequestPlaylistUpdateInfoModel data) {
    return _remotePlaylistApi.patchPlaylist(playlistId, data);
  }

  @override
  Future<ApiResponse<void>> delPlaylist(int playlistId) {
    return _remotePlaylistApi.delPlaylist(playlistId);
  }
}
