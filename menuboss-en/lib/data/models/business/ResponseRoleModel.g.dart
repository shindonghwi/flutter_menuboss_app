// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseRoleModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseRoleModel _$ResponseRoleModelFromJson(Map<String, dynamic> json) =>
    ResponseRoleModel(
      object: json['object'] as String,
      roleId: json['roleId'] as int,
      name: json['name'] as String,
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) =>
              ResponseRolePermissionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      updatedDate: json['updatedDate'] as String,
    );

Map<String, dynamic> _$ResponseRoleModelToJson(ResponseRoleModel instance) =>
    <String, dynamic>{
      'object': instance.object,
      'roleId': instance.roleId,
      'name': instance.name,
      'permissions': instance.permissions,
      'updatedDate': instance.updatedDate,
    };
