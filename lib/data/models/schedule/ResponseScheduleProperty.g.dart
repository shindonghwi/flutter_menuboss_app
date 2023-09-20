// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseScheduleProperty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseScheduleProperty _$ResponseSchedulePropertyFromJson(
        Map<String, dynamic> json) =>
    ResponseScheduleProperty(
      count: json['count'] as int?,
      imageUrl: json['imageUrl'] as String?,
      contentTypes: (json['contentTypes'] as List<dynamic>?)
          ?.map((e) =>
              ResponseSchedulePropertyInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      direction: json['direction'] == null
          ? null
          : ResponseSchedulePropertyInfo.fromJson(
              json['direction'] as Map<String, dynamic>),
      fill: json['fill'] == null
          ? null
          : ResponseSchedulePropertyInfo.fromJson(
              json['fill'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseSchedulePropertyToJson(
        ResponseScheduleProperty instance) =>
    <String, dynamic>{
      'count': instance.count,
      'imageUrl': instance.imageUrl,
      'contentTypes': instance.contentTypes,
      'direction': instance.direction,
      'fill': instance.fill,
    };
