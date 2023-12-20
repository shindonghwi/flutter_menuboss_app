import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/canvas/ResponseCanvasModel.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/domain/repositories/remote/canvas/RemoteCanvasRepository.dart';
import 'package:menuboss/domain/repositories/remote/media/RemoteMediaRepository.dart';

class GetCanvasesUseCase {
  GetCanvasesUseCase();

  final RemoteCanvasRepository _remoteCanvasRepository = GetIt.instance<RemoteCanvasRepository>();

  Future<ApiListResponse<List<ResponseCanvasModel>>> call() async {
    return await _remoteCanvasRepository.getCanvases();
  }
}
