import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/data/models/schedule/SimpleSchedulesModel.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

import 'ResponsePlaylistContent.dart';
import 'ResponsePlaylistProperty.dart';
import 'ResponsePlaylistTime.dart';
import 'ResponsePlaylistsProperty.dart';

part 'ResponsePlaylistsModel.g.dart';

@JsonSerializable()
class ResponsePlaylistsModel {
  final String object;
  final int playlistId;
  final String name;
  final ResponsePlaylistTime? time;
  final ResponsePlaylistsProperty? property;
  String updatedDate;

  ResponsePlaylistsModel({
    required this.object,
    required this.playlistId,
    required this.name,
    required this.time,
    required this.property,
    required this.updatedDate,
  });

  factory ResponsePlaylistsModel.fromJson(Map<String, dynamic> json) => _$ResponsePlaylistsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponsePlaylistsModelToJson(this);

  SimpleSchedulesModel toSimpleSchedulesModelMapper({
    required bool isRequired,
  }) {
    return SimpleSchedulesModel(
      isRequired: isRequired,
      isAddButton: false,
      imageUrl: property?.imageUrl ?? "",
      playlistId: playlistId,
      playListName: name,
      start: time?.start,
      end: time?.end,
      timeIsDuplicate: false,
    );
  }

  ResponsePlaylistsModel toUpDatedAtSimpleMapper() {
    return ResponsePlaylistsModel(
      object: object,
      playlistId: playlistId,
      name: name,
      time: time,
      property: property,
      updatedDate: updatedDate,
    );
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
