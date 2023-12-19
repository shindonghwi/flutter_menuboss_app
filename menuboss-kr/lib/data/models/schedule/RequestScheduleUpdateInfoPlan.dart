import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistTime.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

part 'RequestScheduleUpdateInfoPlan.g.dart';

@JsonSerializable()
class RequestScheduleUpdateInfoPlan {
  final int playlistId;
  final String type;
  final String? startTime;
  final String? endTime;

  RequestScheduleUpdateInfoPlan({
    required this.playlistId,
    required this.type,
    required this.startTime,
    required this.endTime,
  });

  factory RequestScheduleUpdateInfoPlan.fromJson(Map<String, dynamic> json) =>
      _$RequestScheduleUpdateInfoPlanFromJson(json);

  RequestScheduleUpdateInfoPlan copyWith({
    int? playlistId,
    String? type,
    String? startTime,
    String? endTime,
  }) {
    return RequestScheduleUpdateInfoPlan(
      playlistId: playlistId ?? this.playlistId,
      type: type ?? this.type,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  Map<String, dynamic> toJson() => _$RequestScheduleUpdateInfoPlanToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }

}
