import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/media/ResponseMediaCreate.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';

import '../../../../domain/repositories/remote/media/RemoteMediaRepository.dart';
import '../../../models/base/ApiResponse.dart';

class RemoteMediaRepositoryImpl implements RemoteMediaRepository {
  RemoteMediaRepositoryImpl();

  final RemoteMediaRepository _remoteMediaRepository = GetIt.instance<RemoteMediaRepository>();

  @override
  Future<ApiListResponse<List<ResponseMediaModel>>> getMedias(
      {String q = "", int page = 1, int size = 50, String sort = "name_asc"}) {
    return _remoteMediaRepository.getMedias(q: q, page: page, size: size, sort: sort);
  }

  @override
  Future<ApiResponse<ResponseMediaModel>> getMedia(String mediaId) {
    return _remoteMediaRepository.getMedia(mediaId);
  }

  @override
  Future<ApiResponse<ResponseMediaCreate>> postCreateMediaFolder(String mediaId) {
    return _remoteMediaRepository.postCreateMediaFolder(mediaId);
  }

  @override
  Future<ApiResponse<void>> patchMediaName(String mediaId, String name) {
    return _remoteMediaRepository.patchMediaName(mediaId, name);
  }

  @override
  Future<ApiResponse<void>> postMediaMove(List<String> mediaIds, {String? folderId}) {
    return _remoteMediaRepository.postMediaMove(mediaIds, folderId: folderId);
  }

  @override
  Future<ApiResponse<void>> delMedia(List<String> mediaIds) {
    return _remoteMediaRepository.delMedia(mediaIds);
  }
}
