import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:menuboss/data/data_source/remote/file/RemoteFileApi.dart';
import 'package:menuboss/data/models/file/ResponseFileModel.dart';

import '../../../../domain/repositories/remote/file/RemoteFileRepository.dart';
import '../../../models/base/ApiResponse.dart';

class RemoteFileRepositoryImpl implements RemoteFileRepository {
  RemoteFileRepositoryImpl();

  final RemoteFileApi _remoteFileApi = GetIt.instance<RemoteFileApi>();

  @override
  Future<ApiResponse<ResponseFileModel>> postMediaImageUpload(
    String filePath, {
    String? folderId,
    StreamController<double>? streamController,
  }) {
    return _remoteFileApi.postMediaImageUpload(
      filePath,
      folderId: folderId,
      streamController: streamController,
    );
  }

  @override
  Future<ApiResponse<ResponseFileModel>> postMediaVideoUpload(
    String filePath, {
    String? folderId,
    StreamController<double>? streamController,
  }) {
    return _remoteFileApi.postMediaVideoUpload(
      filePath,
      folderId: folderId,
      streamController: streamController,
    );
  }

  @override
  Future<ApiResponse<ResponseFileModel>> postProfileImageUpload(
    String filePath, {
    StreamController<double>? streamController,
  }) {
    return _remoteFileApi.postProfileImageUpload(
      filePath,
      streamController: streamController,
    );
  }
}
