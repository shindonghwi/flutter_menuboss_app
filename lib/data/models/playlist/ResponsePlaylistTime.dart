import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

part 'ResponsePlaylistTime.g.dart';

@JsonSerializable()
class ResponsePlaylistTime {
  final String? start;
  final String? end;

  ResponsePlaylistTime({
    required this.start,
    required this.end,
  });

  factory ResponsePlaylistTime.fromJson(Map<String, dynamic> json) => _$ResponsePlaylistTimeFromJson(json);

  Map<String, dynamic> toJson() => _$ResponsePlaylistTimeToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
