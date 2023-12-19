import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

import 'ResponseSchedulesPropertyInfo.dart';

part 'ResponseSchedulesProperty.g.dart';

@JsonSerializable()
class ResponseSchedulesProperty {
  final int? count;
  final String? imageUrl;
  final List<ResponseSchedulesPropertyInfo>? contentTypes;
  final String? direction;

  ResponseSchedulesProperty({
    required this.count,
    required this.imageUrl,
    required this.contentTypes,
    required this.direction,
  });

  factory ResponseSchedulesProperty.fromJson(Map<String, dynamic> json) => _$ResponseSchedulesPropertyFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseSchedulesPropertyToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
