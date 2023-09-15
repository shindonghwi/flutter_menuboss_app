import 'package:json_annotation/json_annotation.dart';

part 'RequestPlaylistUpdateInfoProperty.g.dart';

@JsonSerializable()
class RequestPlaylistUpdateInfoProperty {
  final String direction;
  final String fill;

  RequestPlaylistUpdateInfoProperty({
    this.direction = "Horizontal",
    this.fill = "Fit",
  });

  factory RequestPlaylistUpdateInfoProperty.fromJson(Map<String, dynamic> json) =>
      _$RequestPlaylistUpdateInfoPropertyFromJson(json);

  RequestPlaylistUpdateInfoProperty copyWith({
    String? direction,
    String? fill,
  }) {
    return RequestPlaylistUpdateInfoProperty(
      direction: direction ?? this.direction,
      fill: fill ?? this.fill,
    );
  }

  Map<String, dynamic> toJson() => _$RequestPlaylistUpdateInfoPropertyToJson(this);
}
