import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/ApiListResponse.dart';
import 'package:menuboss/data/models/ApiResponse.dart';
import 'package:menuboss/data/models/playlist/RequestPlaylistUpdateInfoModel.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../BaseApiUtil.dart';
import '../Service.dart';

class RemotePlaylistApi {
  RemotePlaylistApi();

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  /// 플레이 리스트 목록 조회
  Future<ApiListResponse<List<ResponsePlaylistModel>>> getPlaylists() async {
    final response = await Service.getApi(
      type: ServiceType.Playlist,
      endPoint: null,
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiListResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        list: null,
        count: 0,
      );
    } else {
      return ApiListResponse.fromJson(
        jsonDecode(response.body),
        (json) {
          return List<ResponsePlaylistModel>.from(
            json.map((item) => ResponsePlaylistModel.fromJson(item as Map<String, dynamic>)),
          );
        },
      );
    }
  }

  /// 플레이 리스트 정보 조회
  Future<ApiResponse<ResponsePlaylistModel>> getPlaylist(int playlistId) async {
    final response = await Service.getApi(
      type: ServiceType.Playlist,
      endPoint: "$playlistId",
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) => ResponsePlaylistModel.fromJson(json),
      );
    }
  }

  /// 플레이 리스트 등록
  /// return playlistId
  Future<ApiResponse<ResponsePlaylistModel>> postPlaylist(RequestPlaylistUpdateInfoModel data) async {
    final response = await Service.postApi(
      type: ServiceType.Playlist,
      endPoint: null,
      jsonBody: data.toJson(),
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) => ResponsePlaylistModel.fromJson(json),
      );
    }
  }

  /// 플레이 리스트 정보 업데이트
  Future<ApiResponse<void>> patchPlaylist(int playlistId, RequestPlaylistUpdateInfoModel data) async {
    final response = await Service.patchApi(
      type: ServiceType.Playlist,
      endPoint: "$playlistId",
      jsonBody: data.toJson(),
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
            (json) => ResponsePlaylistModel.fromJson(json),
      );
    }
  }

  /// 플레이 리스트 이름 업데이트
  Future<ApiResponse<void>> patchPlaylistName(int playlistId, String name) async {
    final response = await Service.patchApi(
      type: ServiceType.Playlist,
      endPoint: "$playlistId/name",
      jsonBody: null,
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
            (json) => ResponsePlaylistModel.fromJson(json),
      );
    }
  }

  /// 플레이 리스트 삭제
  Future<ApiResponse<void>> delPlaylist(int playlistId) async {
    final response = await Service.deleteApi(
      type: ServiceType.Playlist,
      endPoint: "$playlistId",
      jsonBody: null,
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
            (json) => ResponsePlaylistModel.fromJson(json),
      );
    }
  }
}
