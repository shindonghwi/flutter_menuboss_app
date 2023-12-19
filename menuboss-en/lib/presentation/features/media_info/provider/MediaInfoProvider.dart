import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/ResponseMediaInfoModel.dart';
import 'package:menuboss/domain/usecases/remote/media/GetMediaUseCase.dart';
import 'package:menuboss_common/utils/UiState.dart';

final mediaInformationProvider = StateNotifierProvider<MediaInfoNotifier, UIState<ResponseMediaInfoModel?>>(
      (ref) => MediaInfoNotifier(),
);

class MediaInfoNotifier extends StateNotifier<UIState<ResponseMediaInfoModel?>> {
  MediaInfoNotifier() : super(Idle());

  final GetMediaUseCase _mediaInfoUseCase = GetIt.instance<GetMediaUseCase>();

  /// 미디어 정보조회
  void requestMediaInformation(String mediaId) {
    state = Loading();
    _mediaInfoUseCase.call(mediaId).then((response) async{
      if (response.status == 200) {
        state = Success(response.data);
      } else {
        state = Failure(response.message);
      }
    });
  }

  void init() {
    state = Idle();
  }
}
