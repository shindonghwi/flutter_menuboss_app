import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

import 'ResponseRolePermissionModel.dart';

part 'ResponseRoleModel.g.dart';

@JsonSerializable()
class ResponseRoleModel {
  final String object;
  final int roleId;
  final String name;
  final List<ResponseRolePermissionModel>? permissions;
  final String updatedDate;

  ResponseRoleModel({
    required this.object,
    required this.roleId,
    required this.name,
    required this.permissions,
    required this.updatedDate,
  });

  factory ResponseRoleModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseRoleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseRoleModelToJson(this);

  ResponseRoleModel copyWith({
    String? object,
    int? roleId,
    String? name,
    List<ResponseRolePermissionModel>? permissions,
    String? updatedDate,
  }) {
    return ResponseRoleModel(
      object: object ?? this.object,
      roleId: roleId ?? this.roleId,
      name: name ?? this.name,
      permissions: permissions ?? this.permissions,
      updatedDate: updatedDate ?? this.updatedDate,
    );
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
