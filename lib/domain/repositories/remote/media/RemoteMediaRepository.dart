import 'dart:async';

import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';

import '../../../../data/models/media/ResponseMediaCreate.dart';
import '../../../../data/models/media/ResponseMediaModel.dart';

abstract class RemoteMediaRepository {
  /// 미디어 목록 조회
  Future<ApiListResponse<List<ResponseMediaModel>>> getMedias({
    String q = "",
    int page = 1,
    int size = 50,
    String sort = "name_asc",
  });

  /// 미디어 정보 조회
  Future<ApiResponse<ResponseMediaModel>> getMedia(String mediaId);

  /// 폴더 생성
  Future<ApiResponse<ResponseMediaCreate>> postCreateMediaFolder(String mediaId);

  /// 미디어 이름 변경
  Future<ApiResponse<void>> patchMediaName(String mediaId, String name);

  /// 미디어 파일 이동
  Future<ApiResponse<void>> postMediaMove(List<String> mediaIds, {String? folderId});

  /// 미디어 파일 삭제
  Future<ApiResponse<void>> delMedia(List<String> mediaIds);
}
