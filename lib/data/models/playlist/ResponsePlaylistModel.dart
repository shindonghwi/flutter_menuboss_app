import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/data/models/schedule/SimpleSchedulesModel.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

import 'ResponsePlaylistContent.dart';
import 'ResponsePlaylistProperty.dart';
import 'ResponsePlaylistTime.dart';

part 'ResponsePlaylistModel.g.dart';

@JsonSerializable()
class ResponsePlaylistModel {
  final String object;
  final int playlistId;
  final String name;
  final ResponsePlaylistTime? time;
  final ResponsePlaylistProperty? property;
  final List<ResponsePlaylistContent>? contents;
  String updatedDate;

  ResponsePlaylistModel({
    required this.object,
    required this.playlistId,
    required this.name,
    required this.time,
    required this.property,
    required this.contents,
    required this.updatedDate,
  });

  factory ResponsePlaylistModel.fromJson(Map<String, dynamic> json) => _$ResponsePlaylistModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponsePlaylistModelToJson(this);

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

  ResponsePlaylistModel toupdatedDateSimpleMapper() {
    return ResponsePlaylistModel(
      object: object,
      playlistId: playlistId,
      name: name,
      time: time,
      property: property,
      contents: contents,
      updatedDate: updatedDate,
    );
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
