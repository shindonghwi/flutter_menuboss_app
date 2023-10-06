import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/data/models/schedule/SimpleSchedulesModel.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

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
  final ResponsePlaylistsProperty? property;
  String updatedAt;

  ResponsePlaylistsModel({
    required this.object,
    required this.playlistId,
    required this.name,
    required this.property,
    required this.updatedAt,
  });

  factory ResponsePlaylistsModel.fromJson(Map<String, dynamic> json) => _$ResponsePlaylistsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponsePlaylistsModelToJson(this);

  ResponsePlaylistsModel toUpDatedAtSimpleMapper() {
    return ResponsePlaylistsModel(
      object: object,
      playlistId: playlistId,
      name: name,
      property: property,
      updatedAt: _updatedAtMapper(updatedAt),
    );
  }

  String _updatedAtMapper(String updatedAt) {
    return StringUtil.formatSimpleDate(updatedAt);
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
