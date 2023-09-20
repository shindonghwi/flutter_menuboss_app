import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

import 'ResponseSchedulePropertyInfo.dart';

part 'ResponseScheduleProperty.g.dart';

@JsonSerializable()
class ResponseScheduleProperty {
  final int? count;
  final String? imageUrl;
  final List<ResponseSchedulePropertyInfo>? contentTypes;
  final ResponseSchedulePropertyInfo? direction;
  final ResponseSchedulePropertyInfo? fill;

  ResponseScheduleProperty({
    required this.count,
    required this.imageUrl,
    required this.contentTypes,
    required this.direction,
    required this.fill,
  });

  factory ResponseScheduleProperty.fromJson(Map<String, dynamic> json) => _$ResponseSchedulePropertyFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseSchedulePropertyToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
