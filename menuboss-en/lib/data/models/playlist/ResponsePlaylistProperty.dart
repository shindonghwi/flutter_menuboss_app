import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

import 'ResponsePlaylistPropertyInfo.dart';

part 'ResponsePlaylistProperty.g.dart';

@JsonSerializable()
class ResponsePlaylistProperty {
  final int? count;
  final String? imageUrl;
  final List<ResponsePlaylistPropertyInfo>? contentTypes;
  final ResponsePlaylistPropertyInfo? direction;
  final ResponsePlaylistPropertyInfo? fill;

  ResponsePlaylistProperty({
    required this.count,
    required this.imageUrl,
    required this.contentTypes,
    required this.direction,
    required this.fill,
  });

  factory ResponsePlaylistProperty.fromJson(Map<String, dynamic> json) => _$ResponsePlaylistPropertyFromJson(json);

  Map<String, dynamic> toJson() => _$ResponsePlaylistPropertyToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
