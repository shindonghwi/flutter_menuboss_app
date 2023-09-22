// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseMediaModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMediaModel _$ResponseMediaModelFromJson(Map<String, dynamic> json) =>
    ResponseMediaModel(
      object: json['object'] as String? ?? "",
      mediaId: json['mediaId'] as String? ?? "",
      name: json['name'] as String? ?? "",
      type: json['type'] == null
          ? null
          : ResponseMediaPropertyInfo.fromJson(
              json['type'] as Map<String, dynamic>),
      property: json['property'] == null
          ? null
          : ResponseMediaProperty.fromJson(
              json['property'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ResponseMediaModelToJson(ResponseMediaModel instance) =>
    <String, dynamic>{
      'object': instance.object,
      'mediaId': instance.mediaId,
      'name': instance.name,
      'type': instance.type,
      'property': instance.property,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
