import 'package:json_annotation/json_annotation.dart';

part 'RequestPlaylistUpdateInfoContents.g.dart';

@JsonSerializable()
class RequestPlaylistUpdateInfoContents {
  final String contentId;
  final int? duration;

  RequestPlaylistUpdateInfoContents({
    required this.contentId,
    required this.duration,
  });

  factory RequestPlaylistUpdateInfoContents.fromJson(Map<String, dynamic> json) => _$RequestPlaylistUpdateInfoContentsFromJson(json);

  Map<String, dynamic> toJson() => _$RequestPlaylistUpdateInfoContentsToJson(this);
}