import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/ResponseMediaProperty.dart';
import 'package:menuboss/data/models/media/SimpleMediaContentModel.dart';
import 'package:menuboss/data/models/playlist/RequestPlaylistUpdateInfoModel.dart';
import 'package:menuboss/domain/usecases/remote/media/GetMediaUseCase.dart';
import 'package:menuboss/domain/usecases/remote/playlist/PostPlaylistUseCase.dart';
import 'package:menuboss/presentation/features/create/playlist/provider/PlaylistSaveInfoProvider.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final detailPreviewItemProcessProvider = StateNotifierProvider<DetailPreviewItemProcessNotifier, UIState<List<SimpleMediaContentModel>>>(
      (ref) => DetailPreviewItemProcessNotifier(),
);

class DetailPreviewItemProcessNotifier extends StateNotifier<UIState<List<SimpleMediaContentModel>>> {
  DetailPreviewItemProcessNotifier() : super(Idle());

  final GetMediaUseCase _getMediaUseCase = GetIt.instance<GetMediaUseCase>();

  PlaylistSettingType scaleType = PlaylistSettingType.Fill;

  void conversionStart(PlaylistSettingType contentScaleType, List<SimpleMediaContentModel> items) async {
    scaleType = contentScaleType;
    state = Loading();

    var futures = items.asMap().entries.map((e) async {
      final index = e.key;
      final item = e.value;

      if (item.type.toString().toLowerCase() == "video") {
        return await _getMediaUseCase.call(item.id.toString()).then((response) {
          if (response.status == 200) {
            final data = response.data;
            return SimpleMediaContentModel(
              index: index,
              object: data?.object,
              id: data?.mediaId,
              name: data?.name,
              type: data?.type?.code,
              property: ResponseMediaProperty(
                count: data?.property?.count,
                width: data?.property?.width,
                height: data?.property?.height,
                size: data?.property?.size,
                duration: data?.property?.duration,
                rotation: data?.property?.rotation,
                codec: data?.property?.codec,
                contentType: data?.property?.contentType,
                imageUrl: data?.property?.imageUrl,
                videoUrl: data?.property?.videoUrl,
              ),
            );
          }
          return item;
        });
      }
      return item;
    });
    var resultList = await Future.wait(futures);
    state = Success(resultList);
  }

  void init(){
    state = Idle();
  }
}