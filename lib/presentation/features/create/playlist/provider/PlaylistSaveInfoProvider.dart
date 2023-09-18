import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/SimpleMediaContentModel.dart';
import 'package:menuboss/data/models/playlist/RequestPlaylistUpdateInfoContents.dart';
import 'package:menuboss/data/models/playlist/RequestPlaylistUpdateInfoModel.dart';
import 'package:menuboss/data/models/playlist/RequestPlaylistUpdateInfoProperty.dart';

enum PlaylistSettingType {
  Horizontal,
  Vertical,
  Fit,
  Fill,
}

final Map<PlaylistSettingType, String> playListSaveParams = {
  PlaylistSettingType.Horizontal: "Horizontal",
  PlaylistSettingType.Vertical: "Vertical",
  PlaylistSettingType.Fit: "Fit",
  PlaylistSettingType.Fill: "Fill"
};

final PlaylistSaveInfoProvider =
    StateNotifierProvider<PlaylistSaveInfoProviderNotifier, RequestPlaylistUpdateInfoModel>(
  (ref) => PlaylistSaveInfoProviderNotifier(),
);

class PlaylistSaveInfoProviderNotifier extends StateNotifier<RequestPlaylistUpdateInfoModel> {
  PlaylistSaveInfoProviderNotifier()
      : super(
          RequestPlaylistUpdateInfoModel(
            name: "",
            property: RequestPlaylistUpdateInfoProperty(),
            contents: [],
          ),
        );

  /// 이름 변경
  void changeName(String name) {
    state = state.copyWith(name: name);
  }

  /// 방향 변경
  void changeDirection(PlaylistSettingType type) {
    state = state.copyWith(property: state.property.copyWith(direction: playListSaveParams[type]!));
  }

  /// 스케일 변경
  void changeFill(PlaylistSettingType type) {
    state = state.copyWith(property: state.property.copyWith(fill: playListSaveParams[type]!));
  }

  /// 콘텐츠 추가
  void changeContents(List<SimpleMediaContentModel> items) {
    state = state.copyWith(
      contents: items
          .map((e) => RequestPlaylistUpdateInfoContents(
                duration: e.property?.duration,
                contentId: e.id.toString(),
              ))
          .toList(),
    );
  }

  /// 상태 초기화
  void init() {
    state = RequestPlaylistUpdateInfoModel(
      name: "",
      property: RequestPlaylistUpdateInfoProperty(),
      contents: [],
    );
  }
}
