import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

import '../playlist/ResponsePlaylistModel.dart';
import 'ResponseSchedulesProperty.dart';
import 'SimpleSchedulesModel.dart';

part 'ResponseSchedulesModel.g.dart';

@JsonSerializable()
class ResponseSchedulesModel {
  final String object;
  final int scheduleId;
  final String name;
  final ResponseSchedulesProperty? property;
  final List<ResponsePlaylistModel>? playlists;
  String updatedDate;

  ResponseSchedulesModel({
    required this.object,
    required this.scheduleId,
    required this.name,
    required this.property,
    required this.playlists,
    required this.updatedDate,
  });

  factory ResponseSchedulesModel.fromJson(Map<String, dynamic> json) => _$ResponseSchedulesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseSchedulesModelToJson(this);

  ResponseSchedulesModel toUpDatedAtSimpleMapper() {
    return ResponseSchedulesModel(
      object: object,
      scheduleId: scheduleId,
      name: name,
      property: property,
      playlists: playlists,
      updatedDate: updatedDate,
    );
  }

  ResponseSchedulesModel copyWith({
    String? object,
    int? scheduleId,
    String? name,
    ResponseSchedulesProperty? property,
    List<ResponsePlaylistModel>? playlists,
    String? updatedDate,
  }) {
    return ResponseSchedulesModel(
      object: object ?? this.object,
      scheduleId: scheduleId ?? this.scheduleId,
      name: name ?? this.name,
      property: property ?? this.property,
      playlists: playlists ?? this.playlists,
      updatedDate: updatedDate ?? this.updatedDate,
    );
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
