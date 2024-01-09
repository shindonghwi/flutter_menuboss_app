import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/schedule/SimpleSchedulesModel.dart';

final scheduleTimelineInfoProvider =
    StateNotifierProvider<ScheduleTimelineInfoProviderNotifier, List<SimpleSchedulesModel>>(
  (ref) => ScheduleTimelineInfoProviderNotifier(),
);

class ScheduleTimelineInfoProviderNotifier extends StateNotifier<List<SimpleSchedulesModel>> {
  ScheduleTimelineInfoProviderNotifier() : super([]);

  List<SimpleSchedulesModel> _initialItems = [];

  void setInitialItems(List<SimpleSchedulesModel> items) {
    _initialItems = items;
    state = items;
  }

  SimpleSchedulesModel createScheduleItem(
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

  void replaceItems(List<SimpleSchedulesModel> items) {
    if (items.isEmpty) {
      return;
    }
    // 첫번째 아이템은 제거 (서버에서 전달받은 플레이리스트로 구성)
    // 마지막 아이템은 항상 추가 버튼
    SimpleSchedulesModel lastItem = state.last;
    state = [...items, lastItem];
  }

  void addItem({
    required String defaultTitle,
  }) {
    int newId = state.map((item) => item.playlistId).reduce((curr, next) => curr! < next! ? curr : next)! - 1;
    SimpleSchedulesModel newItem = createScheduleItem(newId, false, false, defaultTitle, "00:00", "00:00");

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

  void removeItemById(int id) {
    List<SimpleSchedulesModel> newState = state.where((item) => item.playlistId != id).toList();
    _checkForOverlappingTimes(newState);
    state = [...newState];
  }

  void removeItemByIndex(int index) {
    List<SimpleSchedulesModel> newState = [...state]..removeAt(index);
    _checkForOverlappingTimes(newState);
    state = [...newState];
  }

  /// @feature: 스케줄 아이템 정렬 - startTime 기준으로 정렬한다.
  void _sortSchedulesByTime(List<SimpleSchedulesModel> schedules) {
    SimpleSchedulesModel firstItem = schedules.first;
    SimpleSchedulesModel lastItem = schedules.last;
    List<SimpleSchedulesModel> itemsToSort = schedules.sublist(1, schedules.length - 1);

    itemsToSort.sort((a, b) => timeOfDayToMinutes(_parseTime(a.start.toString()))
        .compareTo(timeOfDayToMinutes(_parseTime(b.start.toString()))));

    schedules
      ..clear()
      ..add(firstItem)
      ..addAll(itemsToSort)
      ..add(lastItem);
  }

  /// @feature: 스케줄 아이템 업데이트 - id 기반으로 업데이트
  /// @author: 2023/09/21 2:36 PM donghwishin
  /// @description{
  ///   업데이트 아이템을 startTime 기준으로 정렬한다.
  /// }
  void updateItemById(int? id, SimpleSchedulesModel updatedItem) {
    int itemIndex = state.indexWhere((item) => item.playlistId == id);
    if (itemIndex != -1) {
      List<SimpleSchedulesModel> newState = [...state];
      newState[itemIndex] = updatedItem;
      _sortSchedulesByTime(newState);
      _checkForOverlappingTimes(newState);
      state = newState;
    }
  }

  /// @feature: 스케줄 아이템 업데이트 - index 기반으로 업데이트
  /// @author: 2023/09/21 2:36 PM donghwishin
  /// @description{
  ///   업데이트 아이템을 startTime 기준으로 정렬한다.
  /// }

  void updateItemByIndex(int index, SimpleSchedulesModel updatedItem) {
    List<SimpleSchedulesModel> newState = [...state];
    newState[index] = updatedItem;
    _sortSchedulesByTime(newState);
    _checkForOverlappingTimes(newState);
    state = newState;
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
    state = _initialItems;
  }
}
