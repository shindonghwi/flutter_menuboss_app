// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponsePlaylistProperty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponsePlaylistProperty _$ResponsePlaylistPropertyFromJson(
        Map<String, dynamic> json) =>
    ResponsePlaylistProperty(
      count: json['count'] as int?,
      imageUrl: json['imageUrl'] as String?,
      contentTypes: (json['contentTypes'] as List<dynamic>?)
          ?.map((e) =>
              ResponsePlaylistPropertyInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      direction: json['direction'] == null
          ? null
          : ResponsePlaylistPropertyInfo.fromJson(
              json['direction'] as Map<String, dynamic>),
      fill: json['fill'] == null
          ? null
          : ResponsePlaylistPropertyInfo.fromJson(
              json['fill'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponsePlaylistPropertyToJson(
        ResponsePlaylistProperty instance) =>
    <String, dynamic>{
      'count': instance.count,
      'imageUrl': instance.imageUrl,
      'contentTypes': instance.contentTypes,
      'direction': instance.direction,
      'fill': instance.fill,
    };
