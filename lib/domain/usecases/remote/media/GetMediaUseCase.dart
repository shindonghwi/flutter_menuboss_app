import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/domain/repositories/remote/media/RemoteMediaRepository.dart';

class GetMediaUseCase {
  GetMediaUseCase();

  final RemoteMediaRepository _remoteMediaRepository = GetIt.instance<RemoteMediaRepository>();

  Future<ApiResponse<ResponseMediaModel>> call(String mediaId) async {
    return await _remoteMediaRepository.getMedia(mediaId);
  }
}
