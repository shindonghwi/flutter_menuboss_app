import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

part 'ResponsePlaylistContentProperty.g.dart';

@JsonSerializable()
class ResponsePlaylistContentProperty {
  final int size;
  final String imageUrl;

  ResponsePlaylistContentProperty({
    required this.size,
    required this.imageUrl,
  });

  factory ResponsePlaylistContentProperty.fromJson(Map<String, dynamic> json) =>
      _$ResponsePlaylistContentPropertyFromJson(json);

  Map<String, dynamic> toJson() => _$ResponsePlaylistContentPropertyToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
