// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseMediaCreate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMediaCreate _$ResponseMediaCreateFromJson(Map<String, dynamic> json) =>
    ResponseMediaCreate(
      object: json['object'] as String?,
      mediaId: json['mediaId'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      property: json['property'] == null
          ? null
          : ResponseMediaProperty.fromJson(
              json['property'] as Map<String, dynamic>),
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => ResponseMediaFiles.fromJson(e as Map<String, dynamic>))
          .toList(),
      updatedAt: json['updatedAt'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ResponseMediaCreateToJson(
        ResponseMediaCreate instance) =>
    <String, dynamic>{
      'object': instance.object,
      'mediaId': instance.mediaId,
      'type': instance.type,
      'name': instance.name,
      'property': instance.property,
      'files': instance.files,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
    };
