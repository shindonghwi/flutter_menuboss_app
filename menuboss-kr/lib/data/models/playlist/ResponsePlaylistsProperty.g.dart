// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponsePlaylistsProperty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponsePlaylistsProperty _$ResponsePlaylistsPropertyFromJson(
        Map<String, dynamic> json) =>
    ResponsePlaylistsProperty(
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
    );

Map<String, dynamic> _$ResponsePlaylistsPropertyToJson(
        ResponsePlaylistsProperty instance) =>
    <String, dynamic>{
      'count': instance.count,
      'imageUrl': instance.imageUrl,
      'contentTypes': instance.contentTypes,
      'direction': instance.direction,
    };
