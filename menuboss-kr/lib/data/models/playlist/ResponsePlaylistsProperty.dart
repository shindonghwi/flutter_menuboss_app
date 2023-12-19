import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

import 'ResponsePlaylistPropertyInfo.dart';

part 'ResponsePlaylistsProperty.g.dart';

@JsonSerializable()
class ResponsePlaylistsProperty {
  final int? count;
  final String? imageUrl;
  final List<ResponsePlaylistPropertyInfo>? contentTypes;
  final String? direction;

  ResponsePlaylistsProperty({
    required this.count,
    required this.imageUrl,
    required this.contentTypes,
    required this.direction,
  });

  factory ResponsePlaylistsProperty.fromJson(Map<String, dynamic> json) => _$ResponsePlaylistsPropertyFromJson(json);

  Map<String, dynamic> toJson() => _$ResponsePlaylistsPropertyToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
