import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

part 'ResponseMeBusinessCount.g.dart';

@JsonSerializable()
class ResponseMeBusinessCount {
  final int? screen;

  ResponseMeBusinessCount({
    required this.screen,
  });

  factory ResponseMeBusinessCount.fromJson(Map<String, dynamic> json) =>
      _$ResponseMeBusinessCountFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeBusinessCountToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
