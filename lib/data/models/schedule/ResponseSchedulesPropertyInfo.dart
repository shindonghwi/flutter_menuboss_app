import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

part 'ResponseSchedulesPropertyInfo.g.dart';

@JsonSerializable()
class ResponseSchedulesPropertyInfo {
  final String code;
  final String name;

  ResponseSchedulesPropertyInfo({
    required this.code,
    required this.name,
  });

  factory ResponseSchedulesPropertyInfo.fromJson(Map<String, dynamic> json) =>
      _$ResponseSchedulesPropertyInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseSchedulesPropertyInfoToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
