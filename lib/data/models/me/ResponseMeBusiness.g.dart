// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseMeBusiness.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMeBusiness _$ResponseMeBusinessFromJson(Map<String, dynamic> json) =>
    ResponseMeBusiness(
      title: json['title'] as String?,
      role: json['role'] as String?,
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) =>
              ResponseMeBusinessPermissions.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseMeBusinessToJson(ResponseMeBusiness instance) =>
    <String, dynamic>{
      'title': instance.title,
      'role': instance.role,
      'permissions': instance.permissions,
    };
