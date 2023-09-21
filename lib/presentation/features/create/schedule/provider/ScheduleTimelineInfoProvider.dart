import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/schedule/SimpleSchedulesModel.dart';
import 'package:menuboss/presentation/utils/Common.dart';

final ScheduleTimelineInfoProvider = StateNotifierProvider<ScheduleTimelineInfoProviderNotifier, List<SimpleSchedulesModel>>(
  (ref) => ScheduleTimelineInfoProviderNotifier(),
);

class ScheduleTimelineInfoProviderNotifier extends StateNotifier<List<SimpleSchedulesModel>> {
  ScheduleTimelineInfoProviderNotifier() : super(_initialState());

  static List<SimpleSchedulesModel> _initialState() {
    return [
      _createScheduleItem(
          -1, true, false, GetIt.instance<AppLocalization>().get().create_schedule_default_playlist_title_basic, "00:00", "24:00"),
      _createScheduleItem(
          -2, false, false, GetIt.instance<AppLocalization>().get().create_schedule_default_playlist_title_dawn, "00:00", "06:00"),
      _createScheduleItem(
          -3, false, false, GetIt.instance<AppLocalization>().get().create_schedule_default_playlist_title_breakfast, "06:00", "11:00"),
      _createScheduleItem(
          -4, false, false, GetIt.instance<AppLocalization>().get().create_schedule_default_playlist_title_lunch, "11:00", "15:00"),
      _createScheduleItem(
          -5, false, false, GetIt.instance<AppLocalization>().get().create_schedule_default_playlist_title_dinner, "15:00", "24:00"),
      _createScheduleItem(-6, false, true, "", null, null),
    ];
  }

  static SimpleSchedulesModel _createScheduleItem(
    int playlistId,
    bool isRequired,
    bool isAddButton,
    String playListName,
    String? start,
    String? end,
  ) {
    return SimpleSchedulesModel(
      isRequired: isRequired,
      isAddButton: isAddButton,
      imageUrl: "",
      playlistId: playlistId,
      playListName: playListName,
      start: start,
      end: end,
      timeIsDuplicate: false,
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
    _checkForOverlappingTimes(newState);
    state = [...newState];
  }

  void removeItem(int id) {
    List<SimpleSchedulesModel> newState = state.where((item) => item.playlistId != id).toList();
    _checkForOverlappingTimes(newState);
    state = [...newState];
  }

  /// @feature: 스케줄 아이템 업데이트
  /// @author: 2023/09/21 2:36 PM donghwishin
  /// @description{
  ///   업데이트 아이템을 startTime 기준으로 정렬한다.
  /// }
  void updateItem(int? id, SimpleSchedulesModel updatedItem) {
    int itemIndex = state.indexWhere((item) => item.playlistId == id);
    if (itemIndex != -1) {
      List<SimpleSchedulesModel> newState = [...state];
      newState[itemIndex] = updatedItem;

      // 첫 번째와 마지막 아이템을 분리
      SimpleSchedulesModel firstItem = newState.first;
      SimpleSchedulesModel lastItem = newState.last;

      // 첫 번째와 마지막 아이템을 제외한 아이템들만 추출
      List<SimpleSchedulesModel> itemsToSort = newState.sublist(1, newState.length - 1);

      // start 시간을 기준으로 정렬
      itemsToSort
          .sort((a, b) => timeOfDayToMinutes(_parseTime(a.start.toString())).compareTo(timeOfDayToMinutes(_parseTime(b.start.toString()))));

      // 정렬된 리스트를 다시 합치기
      newState = [firstItem, ...itemsToSort, lastItem];

      _checkForOverlappingTimes(newState);
      state = [...newState];
    }
  }

  /// 시간 중복 체크
  void _checkForOverlappingTimes(List<SimpleSchedulesModel> schedules) {
    // 첫 번째와 마지막 아이템을 제외하기 위해 루프 인덱스를 1부터 시작하고 length - 1까지 실행
    for (int i = 1; i < schedules.length - 1; i++) {
      final currentStartMinutes = timeOfDayToMinutes(_parseTime(schedules[i].start.toString()));
      final currentEndMinutes = timeOfDayToMinutes(_parseTime(schedules[i].end.toString()));

      bool isCurrentItemOverlapping = false;

      for (int j = 1; j < schedules.length - 1; j++) {
        if (i != j) {
          final compareStartMinutes = timeOfDayToMinutes(_parseTime(schedules[j].start.toString()));
          final compareEndMinutes = timeOfDayToMinutes(_parseTime(schedules[j].end.toString()));

          bool overlaps = (currentStartMinutes >= compareStartMinutes && currentStartMinutes < compareEndMinutes) ||
              (currentEndMinutes > compareStartMinutes && currentEndMinutes <= compareEndMinutes) ||
              (currentStartMinutes == compareStartMinutes && currentEndMinutes == compareEndMinutes);

          if (overlaps) {
            isCurrentItemOverlapping = true;
            schedules[j] = schedules[j].copyWith(timeIsDuplicate: true);
          }
        }
      }

      if (isCurrentItemOverlapping) {
        schedules[i] = schedules[i].copyWith(timeIsDuplicate: true);
      } else {
        schedules[i] = schedules[i].copyWith(timeIsDuplicate: false);
      }
    }
  }


  int timeOfDayToMinutes(TimeOfDay time) {
    return time.hour * 60 + time.minute;
  }

  TimeOfDay _parseTime(String time) {
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  /// timeIsDuplicate 속성이 true인 아이템이 하나라도 있는지 확인
  bool hasAnyOverlappingTimes() {
    // 첫 번째와 마지막 아이템을 제외한 리스트를 생성
    List<SimpleSchedulesModel> filteredSchedules = state.sublist(1, state.length - 1);
    return filteredSchedules.any((item) => item.timeIsDuplicate);
  }


  void init() {
    state = _initialState();
  }
}
