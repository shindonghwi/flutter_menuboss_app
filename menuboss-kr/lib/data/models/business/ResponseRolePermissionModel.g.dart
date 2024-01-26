// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseRolePermissionModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseRolePermissionModel _$ResponseRolePermissionModelFromJson(
        Map<String, dynamic> json) =>
    ResponseRolePermissionModel(
      group: json['group'] as String,
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ResponseRolePermissionModelToJson(
        ResponseRolePermissionModel instance) =>
    <String, dynamic>{
      'group': instance.group,
      'types': instance.types,
    };
