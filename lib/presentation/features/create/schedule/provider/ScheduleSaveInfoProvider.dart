import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistTime.dart';
import 'package:menuboss/data/models/schedule/RequestScheduleUpdateInfoModel.dart';
import 'package:menuboss/data/models/schedule/RequestScheduleUpdateInfoPlan.dart';
import 'package:menuboss/data/models/schedule/RequestScheduleUpdateInfoPlaylist.dart';
import 'package:menuboss/data/models/schedule/SimpleSchedulesModel.dart';

final ScheduleSaveInfoProvider =
    StateNotifierProvider<ScheduleSaveInfoProviderNotifier, RequestScheduleUpdateInfoModel>(
  (ref) => ScheduleSaveInfoProviderNotifier(),
);

class ScheduleSaveInfoProviderNotifier extends StateNotifier<RequestScheduleUpdateInfoModel> {
  ScheduleSaveInfoProviderNotifier()
      : super(
          RequestScheduleUpdateInfoModel(
            name: "",
            playlists: [],
            plans: [],
          ),
        );

  /// 이름 변경
  void changeName(String name) {
    state = state.copyWith(name: name);
  }

  /// 플레이리스트 변경
  void changeContentPlaylist(List<SimpleSchedulesModel> items) {
    state = state.copyWith(
      playlists: items.where((element) => !element.isAddButton).toList().asMap().entries.map(
        (entry) {
          int index = entry.key;
          var e = entry.value;
          return RequestScheduleUpdateInfoPlaylist(
              playlistId: e.playlistId!,
              time: index == 0
                  ? null // 첫번째는 basic으로 시간을 넣지 않는다.
                  : ResponsePlaylistTime(
                      start: e.start,
                      end: e.end,
                    ));
        },
      ).toList(),
    );
  }

  /// 플랜 변경
  void changeContentPlan(List<SimpleSchedulesModel> items) {
    state = state.copyWith(
      plans: items
          .where((element) => !element.isAddButton)
          .map(
            (e) => RequestScheduleUpdateInfoPlan(
              playlistId: e.playlistId!,
              type: e.playListName,
              startTime: e.start,
              endTime: e.end,
            ),
          )
          .toList(),
    );
  }

  /// 상태 초기화
  void init() {
    state = RequestScheduleUpdateInfoModel(
      name: "",
      playlists: [],
      plans: [],
    );
  }
}
