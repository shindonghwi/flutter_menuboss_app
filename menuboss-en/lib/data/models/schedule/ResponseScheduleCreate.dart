import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

part 'ResponseScheduleCreate.g.dart';

@JsonSerializable()
class ResponseScheduleCreate {
  final int scheduleId;

  ResponseScheduleCreate({
    required this.scheduleId,
  });

  factory ResponseScheduleCreate.fromJson(Map<String, dynamic> json) => _$ResponseScheduleCreateFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseScheduleCreateToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
