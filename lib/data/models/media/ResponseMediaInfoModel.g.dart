// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseMediaInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMediaInfoModel _$ResponseMediaInfoModelFromJson(
        Map<String, dynamic> json) =>
    ResponseMediaInfoModel(
      object: json['object'] as String? ?? "",
      mediaId: json['mediaId'] as String? ?? "",
      name: json['name'] as String? ?? "",
      type: json['type'] as String?,
      property: json['property'] == null
          ? null
          : ResponseMediaProperty.fromJson(
              json['property'] as Map<String, dynamic>),
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ResponseMediaInfoModelToJson(
        ResponseMediaInfoModel instance) =>
    <String, dynamic>{
      'object': instance.object,
      'mediaId': instance.mediaId,
      'name': instance.name,
      'type': instance.type,
      'property': instance.property,
      'updatedAt': instance.updatedAt,
    };
