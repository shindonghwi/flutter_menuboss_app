import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

import 'ResponseRolePermissionModel.dart';

part 'RequestRoleModel.g.dart';

@JsonSerializable()
class RequestRoleModel {
  final String role;
  final List<ResponseRolePermissionModel> permissions;

  RequestRoleModel({
    required this.role,
    required this.permissions,
  });

  factory RequestRoleModel.fromJson(Map<String, dynamic> json) => _$RequestRoleModelFromJson(json);

  RequestRoleModel copyWith({
    String? role,
    List<ResponseRolePermissionModel>? permissions,
  }) {
    return RequestRoleModel(
      role: role ?? this.role,
      permissions: permissions ?? this.permissions,
    );
  }

  Map<String, dynamic> toJson() => _$RequestRoleModelToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
