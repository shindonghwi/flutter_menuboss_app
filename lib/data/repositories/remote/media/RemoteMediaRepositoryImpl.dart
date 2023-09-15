import 'package:get_it/get_it.dart';
import 'package:menuboss/data/data_source/remote/media/RemoteMediaApi.dart';
import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/media/ResponseMediaCreate.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';

import '../../../../domain/repositories/remote/media/RemoteMediaRepository.dart';
import '../../../models/base/ApiResponse.dart';
import '../../../models/media/ResponseMediaInfoModel.dart';

class RemoteMediaRepositoryImpl implements RemoteMediaRepository {
  RemoteMediaRepositoryImpl();

  final RemoteMediaApi _remoteMediaApi = GetIt.instance<RemoteMediaApi>();

  @override
  Future<ApiListResponse<List<ResponseMediaModel>>> getMedias(
      {String q = "", int page = 1, int size = 10, String sort = "name_asc"}) {
    return _remoteMediaApi.getMedias(q: q, page: page, size: size, sort: sort);
  }

  @override
  Future<ApiResponse<ResponseMediaInfoModel>> getMedia(String mediaId) {
    return _remoteMediaApi.getMedia(mediaId);
  }

  @override
  Future<ApiResponse<ResponseMediaCreate>> postCreateMediaFolder() {
    return _remoteMediaApi.postCreateMediaFolder();
  }

  @override
  Future<ApiResponse<void>> patchMediaName(String mediaId, String name) {
    return _remoteMediaApi.patchMediaName(mediaId, name);
  }

  @override
  Future<ApiResponse<void>> postMediaMove(List<String> mediaIds, {String? folderId}) {
    return _remoteMediaApi.postMediaMove(mediaIds, folderId: folderId);
  }

  @override
  Future<ApiResponse<void>> delMedia(List<String> mediaIds) {
    return _remoteMediaApi.delMedia(mediaIds);
  }
}
