import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

part 'ResponsePlaylistCreate.g.dart';

@JsonSerializable()
class ResponsePlaylistCreate {
  final int playlistId;

  ResponsePlaylistCreate({
    required this.playlistId,
  });

  factory ResponsePlaylistCreate.fromJson(Map<String, dynamic> json) => _$ResponsePlaylistCreateFromJson(json);

  Map<String, dynamic> toJson() => _$ResponsePlaylistCreateToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
