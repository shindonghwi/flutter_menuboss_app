import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/data/models/media/SimpleMediaContentModel.dart';
import 'package:menuboss/domain/usecases/remote/canvas/GetCanvasesUseCase.dart';
import 'package:menuboss/domain/usecases/remote/media/GetMediasUseCase.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetFilterSelector.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final MediaContentsCanvasProvider =
    StateNotifierProvider<MediaContentsCanvasNotifier, UIState<List<SimpleMediaContentModel>>>(
  (ref) => MediaContentsCanvasNotifier(),
);

class MediaContentsCanvasNotifier extends StateNotifier<UIState<List<SimpleMediaContentModel>>> {
  MediaContentsCanvasNotifier() : super(Idle());

  final GetCanvasesUseCase _getCanvasesUseCase = GetIt.instance<GetCanvasesUseCase>();

  /// 캔버스 리스트 요청
  void requestGetCanvases({int? delayed}) {
    state = Loading();
    _getCanvasesUseCase.call().then((response) {
      try {
        if (response.status == 200) {
          state = Success([...response.list?.map((e) => e.toMapperMediaContentModel()) ?? []]);
        } else {
          state = Failure(response.message);
        }
      } catch (e) {
        state = Failure(response.message);
      }
    });
  }
}
