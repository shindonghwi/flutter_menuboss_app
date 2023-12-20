import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

part 'ResponseMeBusinessPermissions.g.dart';

@JsonSerializable()
class ResponseMeBusinessPermissions {
  final String group;
  final List<String>? types;

  ResponseMeBusinessPermissions({
    required this.group,
    required this.types,
  });

  factory ResponseMeBusinessPermissions.fromJson(Map<String, dynamic> json) =>
      _$ResponseMeBusinessPermissionsFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeBusinessPermissionsToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
