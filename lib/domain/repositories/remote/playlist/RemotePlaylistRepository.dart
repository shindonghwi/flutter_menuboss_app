import 'dart:async';

import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistCreate.dart';

import '../../../../data/models/device/ResponseDeviceModel.dart';
import '../../../../data/models/playlist/RequestPlaylistUpdateInfoModel.dart';
import '../../../../data/models/playlist/ResponsePlaylistModel.dart';

abstract class RemotePlaylistRepository {
  /// 플레이 리스트 목록 조회
  Future<ApiListResponse<List<ResponsePlaylistModel>>> getPlaylists();

  /// 플레이 리스트 정보 조회
  Future<ApiResponse<ResponsePlaylistModel>> getPlaylist(int playlistId);

  /// 플레이 리스트 등록
  Future<ApiResponse<ResponsePlaylistCreate>> postPlaylist(RequestPlaylistUpdateInfoModel data);

  /// 플레이 리스트 정보 업데이트
  Future<ApiResponse<void>> patchPlaylist(int playlistId, RequestPlaylistUpdateInfoModel data);

  /// 플레이 리스트 이름 업데이트
  Future<ApiResponse<void>> patchPlaylistName(int playlistId, String name);

  /// 플레이 리스트 삭제
  Future<ApiResponse<void>> delPlaylist(int playlistId);

}
