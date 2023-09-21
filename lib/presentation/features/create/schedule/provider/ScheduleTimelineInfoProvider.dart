import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/schedule/SimpleSchedulesModel.dart';
import 'package:menuboss/presentation/utils/Common.dart';

final ScheduleTimelineInfoProvider =
    StateNotifierProvider<ScheduleTimelineInfoProviderNotifier, List<SimpleSchedulesModel>>(
  (ref) => ScheduleTimelineInfoProviderNotifier(),
);

class ScheduleTimelineInfoProviderNotifier extends StateNotifier<List<SimpleSchedulesModel>> {
  ScheduleTimelineInfoProviderNotifier() : super(_initialState());

  static List<SimpleSchedulesModel> _initialState() {
    return [
      _createScheduleItem(-1, true, false,
          GetIt.instance<AppLocalization>().get().create_schedule_default_playlist_title_basic, "00:00", "24:00"),
      _createScheduleItem(-2, false, false,
          GetIt.instance<AppLocalization>().get().create_schedule_default_playlist_title_dawn, "00:00", "06:00"),
      _createScheduleItem(-3, false, false,
          GetIt.instance<AppLocalization>().get().create_schedule_default_playlist_title_breakfast, "06:00", "11:00"),
      _createScheduleItem(-4, false, false,
          GetIt.instance<AppLocalization>().get().create_schedule_default_playlist_title_lunch, "11:00", "15:00"),
      _createScheduleItem(-5, false, false,
          GetIt.instance<AppLocalization>().get().create_schedule_default_playlist_title_dinner, "15:00", "24:00"),
      _createScheduleItem(-6, false, true, "", "00:00", "00:00"),
    ];
  }

  static SimpleSchedulesModel _createScheduleItem(
      int playlistId, bool isRequired, bool isAddButton, String playListName, String start, String end) {
    return SimpleSchedulesModel(
      isRequired: isRequired,
      isAddButton: isAddButton,
      imageUrl: "",
      playlistId: playlistId,
      playListName: playListName,
      start: start,
      end: end,
    );
  }

  void addItem() {
    int newId = state.map((item) => item.playlistId).reduce((curr, next) => curr! < next! ? curr : next)! - 1;
    SimpleSchedulesModel newItem = _createScheduleItem(newId, false, false, "Playlist Name", "00:00", "00:00");

    int addButtonIndex = state.indexWhere((item) => item.isAddButton);
    List<SimpleSchedulesModel> newState = [...state];
    if (addButtonIndex != -1) {
      newState.insert(addButtonIndex, newItem);
    } else {
      newState.add(newItem);
    }
    state = newState;
  }

  void removeItem(int id) {
    state = [...state.where((item) => item.playlistId != id)];
  }

  void updateItem(int? id, SimpleSchedulesModel updatedItem) {
    int itemIndex = state.indexWhere((item) => item.playlistId == id);
    if (itemIndex != -1) {
      List<SimpleSchedulesModel> newState = [...state];
      newState[itemIndex] = updatedItem;
      state = newState;
    }
  }

  void init() {
    state = _initialState();
  }
}
