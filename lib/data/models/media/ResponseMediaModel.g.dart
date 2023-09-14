// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseMediaModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMediaModel _$ResponseMediaModelFromJson(Map<String, dynamic> json) =>
    ResponseMediaModel(
      object: json['object'] as String,
      mediaId: json['mediaId'] as int,
      name: json['name'] as String,
      type: json['type'] == null
          ? null
          : ResponseMediaPropertyInfo.fromJson(
              json['type'] as Map<String, dynamic>),
      property: json['property'] == null
          ? null
          : ResponseMediaProperty.fromJson(
              json['property'] as Map<String, dynamic>),
      files: json['files'] == null
          ? null
          : ResponseMediaFiles.fromJson(json['files'] as Map<String, dynamic>),
      size: json['size'] as int,
      thumbnailUrl: json['thumbnailUrl'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$ResponseMediaModelToJson(ResponseMediaModel instance) =>
    <String, dynamic>{
      'object': instance.object,
      'mediaId': instance.mediaId,
      'name': instance.name,
      'type': instance.type,
      'property': instance.property,
      'files': instance.files,
      'size': instance.size,
      'thumbnailUrl': instance.thumbnailUrl,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
