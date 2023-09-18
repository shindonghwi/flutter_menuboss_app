import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

import 'ResponsePlaylistContents.dart';
import 'ResponsePlaylistProperty.dart';

part 'ResponsePlaylistModel.g.dart';

@JsonSerializable()
class ResponsePlaylistModel {
  final String object;
  final int playlistId;
  final String name;
  final ResponsePlaylistProperty? property;
  final List<ResponsePlaylistContents>? contents;
  String updatedAt;

  ResponsePlaylistModel({
    required this.object,
    required this.playlistId,
    required this.name,
    required this.property,
    required this.contents,
    required this.updatedAt,
  });

  factory ResponsePlaylistModel.fromJson(Map<String, dynamic> json) => _$ResponsePlaylistModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponsePlaylistModelToJson(this);

  ResponsePlaylistModel toUpDatedAtSimpleMapper() {
    return ResponsePlaylistModel(
      object: object,
      playlistId: playlistId,
      name: name,
      property: property,
      contents: contents,
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
