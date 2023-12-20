import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

part 'ResponseMediaPropertyInfo.g.dart';

@JsonSerializable()
class ResponseMediaPropertyInfo {
  final String code;
  final String name;

  ResponseMediaPropertyInfo({
    required this.code,
    required this.name,
  });

  factory ResponseMediaPropertyInfo.fromJson(Map<String, dynamic> json) =>
      _$ResponseMediaPropertyInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMediaPropertyInfoToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
