import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

import 'RequestScheduleUpdateInfoPlan.dart';
import 'RequestScheduleUpdateInfoPlaylist.dart';

part 'RequestScheduleUpdateInfoModel.g.dart';

@JsonSerializable()
class RequestScheduleUpdateInfoModel {
  final String name;
  final List<RequestScheduleUpdateInfoPlaylist>? playlists;
  final List<RequestScheduleUpdateInfoPlan>? plans;

  RequestScheduleUpdateInfoModel({
    required this.name,
    required this.plans,
    required this.playlists,
  });

  factory RequestScheduleUpdateInfoModel.fromJson(Map<String, dynamic> json) =>
      _$RequestScheduleUpdateInfoModelFromJson(json);

  RequestScheduleUpdateInfoModel copyWith({
    String? name,
    List<RequestScheduleUpdateInfoPlan>? plans,
    List<RequestScheduleUpdateInfoPlaylist>? playlists,
  }) {
    return RequestScheduleUpdateInfoModel(
      name: name ?? this.name,
      plans: plans ?? this.plans,
      playlists: playlists ?? this.playlists,
    );
  }

  Map<String, dynamic> toJson() => _$RequestScheduleUpdateInfoModelToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }

}
