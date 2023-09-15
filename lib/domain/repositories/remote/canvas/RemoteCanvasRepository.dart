import 'dart:async';

import 'package:menuboss/data/models/base/ApiListResponse.dart';
import 'package:menuboss/data/models/canvas/ResponseCanvasModel.dart';

abstract class RemoteCanvasRepository {
  /// 캔버스 목록 조회
  Future<ApiListResponse<List<ResponseCanvasModel>>> getCanvases();
}
