// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseMediaCreate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMediaCreate _$ResponseMediaCreateFromJson(Map<String, dynamic> json) =>
    ResponseMediaCreate(
      object: json['object'] as String,
      mediaId: json['mediaId'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      property: json['property'] == null
          ? null
          : ResponseMediaProperty.fromJson(
              json['property'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$ResponseMediaCreateToJson(
        ResponseMediaCreate instance) =>
    <String, dynamic>{
      'object': instance.object,
      'mediaId': instance.mediaId,
      'name': instance.name,
      'type': instance.type,
      'property': instance.property,
      'createdAt': instance.createdAt,
    };
