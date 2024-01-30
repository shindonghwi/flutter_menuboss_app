import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

part 'ResponseBusinessMemberRole.g.dart';

@JsonSerializable()
class ResponseBusinessMemberRole {
  final int? roleId;
  final String? name;

  ResponseBusinessMemberRole({
    required this.roleId,
    required this.name,
  });

  factory ResponseBusinessMemberRole.fromJson(Map<String, dynamic> json) =>
      _$ResponseBusinessMemberRoleFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBusinessMemberRoleToJson(this);

  ResponseBusinessMemberRole copyWith({
    int? roleId,
    String? name,
  }) {
    return ResponseBusinessMemberRole(
      roleId: roleId ?? this.roleId,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
