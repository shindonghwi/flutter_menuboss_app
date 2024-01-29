// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestRoleModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestRoleModel _$RequestRoleModelFromJson(Map<String, dynamic> json) =>
    RequestRoleModel(
      name: json['name'] as String,
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) =>
              ResponseRolePermissionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RequestRoleModelToJson(RequestRoleModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'permissions': instance.permissions,
    };
