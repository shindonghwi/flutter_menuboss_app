import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

import 'ResponseMeBusinessPermissions.dart';

part 'ResponseMeBusiness.g.dart';

@JsonSerializable()
class ResponseMeBusiness {
  final String? title;
  final String? role;
  final List<ResponseMeBusinessPermissions>? permissions;

  ResponseMeBusiness({
    required this.title,
    required this.role,
    required this.permissions,
  });

  factory ResponseMeBusiness.fromJson(Map<String, dynamic> json) => _$ResponseMeBusinessFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeBusinessToJson(this);

  ResponseMeBusiness copyWith({
    String? title,
    String? role,
    List<ResponseMeBusinessPermissions>? permissions,
  }) {
    return ResponseMeBusiness(
      title: title ?? this.title,
      role: role ?? this.role,
      permissions: permissions ?? this.permissions,
    );
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
