import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/playlist/RequestPlaylistUpdateInfoModel.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../../../models/playlist/ResponsePlaylistCreate.dart';
import '../../../models/playlist/ResponsePlaylistsModel.dart';
import '../BaseApiUtil.dart';
import '../Service.dart';

class RemotePlaylistApi {
  RemotePlaylistApi();

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  /// 플레이 리스트 목록 조회
  Future<ApiListResponse<List<ResponsePlaylistsModel>>> getPlaylists() async {
    try {
      final response = await Service.getApi(
        type: ServiceType.Playlist,
        endPoint: null,
      );

      final errorResponse = BaseApiUtil.isErrorStatusCode(response);
      if (errorResponse != null) {
        return BaseApiUtil.errorListResponse(
          status: errorResponse.status,
          message: errorResponse.message,
        );
      } else {
        return ApiListResponse.fromJson(
          jsonDecode(response.body),
          (json) {
            return List<ResponsePlaylistsModel>.from(
              json.map((item) => ResponsePlaylistsModel.fromJson(item as Map<String, dynamic>)),
            );
          },
        );
      }
    } catch (e) {
      return BaseApiUtil.errorListResponse(
        message: e.toString(),
      );
    }
  }

  /// 플레이 리스트 정보 조회
  Future<ApiResponse<ResponsePlaylistModel>> getPlaylist(int playlistId) async {
    try {
      final response = await Service.getApi(
        type: ServiceType.Playlist,
        endPoint: "$playlistId",
      );

      final errorResponse = BaseApiUtil.isErrorStatusCode(response);
      if (errorResponse != null) {
        return BaseApiUtil.errorResponse(
          status: errorResponse.status,
          message: errorResponse.message,
        );
      } else {
        return ApiResponse.fromJson(
          jsonDecode(response.body),
          (json) => ResponsePlaylistModel.fromJson(json),
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// 플레이 리스트 등록
  /// return playlistId
  Future<ApiResponse<ResponsePlaylistCreate>> postPlaylist(RequestPlaylistUpdateInfoModel data) async {
    try {
      final response = await Service.postApi(
        type: ServiceType.Playlist,
        endPoint: null,
        jsonBody: data.toJson(),
      );

      final errorResponse = BaseApiUtil.isErrorStatusCode(response);
      if (errorResponse != null) {
        return BaseApiUtil.errorResponse(
          status: errorResponse.status,
          message: errorResponse.message,
        );
      } else {
        return ApiResponse.fromJson(
          jsonDecode(response.body),
          (json) => ResponsePlaylistCreate.fromJson(json),
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// 플레이 리스트 정보 업데이트
  Future<ApiResponse<void>> patchPlaylist(int playlistId, RequestPlaylistUpdateInfoModel data) async {
    try {
      final response = await Service.patchApi(
        type: ServiceType.Playlist,
        endPoint: "$playlistId",
        jsonBody: data.toJson(),
      );

      final errorResponse = BaseApiUtil.isErrorStatusCode(response);
      if (errorResponse != null) {
        return BaseApiUtil.errorResponse(
          status: errorResponse.status,
          message: errorResponse.message,
        );
      } else {
        return ApiResponse.fromJson(
          jsonDecode(response.body),
          (json) {},
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }

  /// 플레이 리스트 삭제
  Future<ApiResponse<void>> delPlaylist(int playlistId) async {
    try {
      final response = await Service.deleteApi(
        type: ServiceType.Playlist,
        endPoint: "$playlistId",
        jsonBody: null,
      );

      final errorResponse = BaseApiUtil.isErrorStatusCode(response);
      if (errorResponse != null) {
        return BaseApiUtil.errorResponse(
          status: errorResponse.status,
          message: errorResponse.message,
        );
      } else {
        return ApiResponse.fromJson(
          jsonDecode(response.body),
          (json) {},
        );
      }
    } catch (e) {
      return BaseApiUtil.errorResponse(
        message: e.toString(),
      );
    }
  }
}
