import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

import '../playlist/ResponsePlaylistModel.dart';
import 'ResponseScheduleProperty.dart';

part 'ResponseScheduleModel.g.dart';

@JsonSerializable()
class ResponseScheduleModel {
  final String object;
  final int scheduleId;
  final String name;
  final ResponseScheduleProperty? property;
  final List<ResponsePlaylistModel>? playlists;
  String updatedAt;

  ResponseScheduleModel({
    required this.object,
    required this.scheduleId,
    required this.name,
    required this.property,
    required this.playlists,
    required this.updatedAt,
  });

  factory ResponseScheduleModel.fromJson(Map<String, dynamic> json) => _$ResponseScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseScheduleModelToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
