import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/file/ResponseFileModel.dart';
import 'package:menuboss/domain/repositories/remote/file/RemoteFileRepository.dart';

class PostUploadProfileImageUseCase {
  PostUploadProfileImageUseCase();

  final RemoteFileRepository _remoteFileRepository = GetIt.instance<RemoteFileRepository>();

  Future<ApiResponse<ResponseFileModel>> call(String filePath) async {
    return await _remoteFileRepository.postProfileImageUpload(filePath);
  }
}
