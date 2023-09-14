import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/domain/repositories/remote/media/RemoteMediaRepository.dart';

class GetMediasUseCase {
  GetMediasUseCase();

  final RemoteMediaRepository _remoteMediaRepository = GetIt.instance<RemoteMediaRepository>();

  Future<ApiListResponse<List<ResponseMediaModel>>> call({
    String q = "",
    int page = 1,
    int size = 50,
    String sort = "name_asc",
  }) async {
    return await _remoteMediaRepository.getMedias(q: q, page: page, size: size, sort: sort);
  }
}
