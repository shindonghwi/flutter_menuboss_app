// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseMeBusiness.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMeBusiness _$ResponseMeBusinessFromJson(Map<String, dynamic> json) =>
    ResponseMeBusiness(
      title: json['title'] as String?,
      role: json['role'] as String?,
      count: json['count'] == null
          ? null
          : ResponseMeBusinessCount.fromJson(
              json['count'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : ResponseMeBusinessAddress.fromJson(
              json['address'] as Map<String, dynamic>),
      phone: json['phone'] as String?,
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) =>
              ResponseMeBusinessPermissions.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseMeBusinessToJson(ResponseMeBusiness instance) =>
    <String, dynamic>{
      'title': instance.title,
      'role': instance.role,
      'count': instance.count,
      'address': instance.address,
      'phone': instance.phone,
      'permissions': instance.permissions,
    };
