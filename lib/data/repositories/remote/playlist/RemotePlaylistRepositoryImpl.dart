import 'package:get_it/get_it.dart';
import 'package:menuboss/data/data_source/remote/playlist/RemotePlaylistApi.dart';
import 'package:menuboss/data/models/ApiListResponse.dart';
import 'package:menuboss/data/models/playlist/RequestPlaylistUpdateInfoModel.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';

import '../../../../domain/repositories/remote/playlist/RemotePlaylistRepository.dart';
import '../../../models/ApiResponse.dart';

class RemotePlaylistRepositoryImpl implements RemotePlaylistRepository {
  RemotePlaylistRepositoryImpl();

  final RemotePlaylistApi _remotePlaylistApi = GetIt.instance<RemotePlaylistApi>();

  @override
  Future<ApiListResponse<List<ResponsePlaylistModel>>> getPlaylists() {
    return _remotePlaylistApi.getPlaylists();
  }

  @override
  Future<ApiResponse<void>> getPlaylist(int playlistId) {
    return _remotePlaylistApi.getPlaylist(playlistId);
  }

  @override
  Future<ApiResponse<ResponsePlaylistModel>> postPlaylist(RequestPlaylistUpdateInfoModel data) {
    return _remotePlaylistApi.postPlaylist(data);
  }

  @override
  Future<ApiResponse<void>> patchPlaylist(int playlistId, RequestPlaylistUpdateInfoModel data) {
    return _remotePlaylistApi.patchPlaylist(playlistId, data);
  }

  @override
  Future<ApiResponse<void>> patchPlaylistName(int playlistId, String name) {
    return _remotePlaylistApi.patchPlaylistName(playlistId, name);
  }

  @override
  Future<ApiResponse<void>> delPlaylist(int playlistId) {
    return _remotePlaylistApi.delPlaylist(playlistId);
  }
}
