import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

part 'ResponsePlaylistPropertyInfo.g.dart';

@JsonSerializable()
class ResponsePlaylistPropertyInfo {
  final String code;
  final String name;

  ResponsePlaylistPropertyInfo({
    required this.code,
    required this.name,
  });

  factory ResponsePlaylistPropertyInfo.fromJson(Map<String, dynamic> json) =>
      _$ResponsePlaylistPropertyInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ResponsePlaylistPropertyInfoToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
