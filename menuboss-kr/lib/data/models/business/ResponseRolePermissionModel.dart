import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

part 'ResponseRolePermissionModel.g.dart';

@JsonSerializable()
class ResponseRolePermissionModel {
  final String group;
  final List<String> types;

  ResponseRolePermissionModel({
    required this.group,
    required this.types,
  });

  factory ResponseRolePermissionModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseRolePermissionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseRolePermissionModelToJson(this);

  ResponseRolePermissionModel copyWith({
    String? group,
    List<String>? types,
  }) {
    return ResponseRolePermissionModel(
      group: group ?? this.group,
      types: types ?? this.types,
    );
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
