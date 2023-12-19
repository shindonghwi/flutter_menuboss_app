// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseMeBusinessPermissions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMeBusinessPermissions _$ResponseMeBusinessPermissionsFromJson(
        Map<String, dynamic> json) =>
    ResponseMeBusinessPermissions(
      group: json['group'] as String,
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ResponseMeBusinessPermissionsToJson(
        ResponseMeBusinessPermissions instance) =>
    <String, dynamic>{
      'group': instance.group,
      'types': instance.types,
    };
