import 'package:json_annotation/json_annotation.dart';

part 'RequestPlaylistUpdateInfoProperty.g.dart';

@JsonSerializable()
class RequestPlaylistUpdateInfoProperty {
  final String direction;
  final String fill;

  RequestPlaylistUpdateInfoProperty({
    required this.direction,
    required this.fill,
  });

  factory RequestPlaylistUpdateInfoProperty.fromJson(Map<String, dynamic> json) => _$RequestPlaylistUpdateInfoPropertyFromJson(json);

  Map<String, dynamic> toJson() => _$RequestPlaylistUpdateInfoPropertyToJson(this);
}