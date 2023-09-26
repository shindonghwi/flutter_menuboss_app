import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/file/ResponseFileModel.dart';
import 'package:menuboss/domain/repositories/remote/file/RemoteFileRepository.dart';

class PostUploadMediaVideoUseCase {
  PostUploadMediaVideoUseCase();

  final RemoteFileRepository _remoteFileRepository = GetIt.instance<RemoteFileRepository>();

  Future<ApiResponse<ResponseFileModel>> call(
    String filePath, {
    String? folderId,
    StreamController<double>? streamController,
  }) async {
    return await _remoteFileRepository.postMediaVideoUpload(
      filePath,
      folderId: folderId,
      streamController: streamController,
    );
  }
}
