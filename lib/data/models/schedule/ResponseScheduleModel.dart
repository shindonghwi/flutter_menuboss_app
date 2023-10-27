import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

import '../playlist/ResponsePlaylistModel.dart';
import '../playlist/ResponsePlaylistProperty.dart';
import '../playlist/ResponsePlaylistTime.dart';
import '../playlist/ResponsePlaylistsModel.dart';
import 'ResponseSchedulesProperty.dart';
import 'SimpleSchedulesModel.dart';

part 'ResponseScheduleModel.g.dart';

@JsonSerializable()
class ResponseScheduleModel {
  final String object;
  final int scheduleId;
  final String name;
  final List<ResponsePlaylistsModel>? playlists;
  String updatedDate;

  ResponseScheduleModel({
    required this.object,
    required this.scheduleId,
    required this.name,
    required this.playlists,
    required this.updatedDate,
  });

  factory ResponseScheduleModel.fromJson(Map<String, dynamic> json) => _$ResponseScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseScheduleModelToJson(this);

  ResponseScheduleModel toupdatedDateSimpleMapper() {
    return ResponseScheduleModel(
      object: object,
      scheduleId: scheduleId,
      name: name,
      playlists: playlists,
      updatedDate: updatedDate,
    );
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
