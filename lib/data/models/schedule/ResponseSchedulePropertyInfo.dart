import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

part 'ResponseSchedulePropertyInfo.g.dart';

@JsonSerializable()
class ResponseSchedulePropertyInfo {
  final String code;
  final String name;

  ResponseSchedulePropertyInfo({
    required this.code,
    required this.name,
  });

  factory ResponseSchedulePropertyInfo.fromJson(Map<String, dynamic> json) =>
      _$ResponseSchedulePropertyInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseSchedulePropertyInfoToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
