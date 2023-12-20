import 'package:get_it/get_it.dart';
import 'package:menuboss/data/data_source/remote/canvas/RemoteCanvasApi.dart';
import 'package:menuboss/data/models/base/ApiListResponse.dart';

import '../../../../domain/repositories/remote/canvas/RemoteCanvasRepository.dart';
import '../../../models/canvas/ResponseCanvasModel.dart';

class RemoteCanvasRepositoryImpl implements RemoteCanvasRepository {
  RemoteCanvasRepositoryImpl();

  final RemoteCanvasApi _remoteCanvasApi = GetIt.instance<RemoteCanvasApi>();

  @override
  Future<ApiListResponse<List<ResponseCanvasModel>>> getCanvases() {
    return _remoteCanvasApi.getCanvases();
  }
}
