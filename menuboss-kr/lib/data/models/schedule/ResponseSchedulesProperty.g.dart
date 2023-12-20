// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseSchedulesProperty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseSchedulesProperty _$ResponseSchedulesPropertyFromJson(
        Map<String, dynamic> json) =>
    ResponseSchedulesProperty(
      count: json['count'] as int?,
      imageUrl: json['imageUrl'] as String?,
      contentTypes: (json['contentTypes'] as List<dynamic>?)
          ?.map((e) =>
              ResponseSchedulesPropertyInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      direction: json['direction'] as String?,
    );

Map<String, dynamic> _$ResponseSchedulesPropertyToJson(
        ResponseSchedulesProperty instance) =>
    <String, dynamic>{
      'count': instance.count,
      'imageUrl': instance.imageUrl,
      'contentTypes': instance.contentTypes,
      'direction': instance.direction,
    };
