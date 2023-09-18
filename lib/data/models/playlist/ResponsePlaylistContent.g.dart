// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponsePlaylistContent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponsePlaylistContent _$ResponsePlaylistContentFromJson(
        Map<String, dynamic> json) =>
    ResponsePlaylistContent(
      contentId: json['contentId'] as String,
      name: json['name'] as String,
      type: ResponsePlaylistPropertyInfo.fromJson(
          json['type'] as Map<String, dynamic>),
      duration: json['duration'] as int,
      property: ResponsePlaylistContentProperty.fromJson(
          json['property'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponsePlaylistContentToJson(
        ResponsePlaylistContent instance) =>
    <String, dynamic>{
      'contentId': instance.contentId,
      'name': instance.name,
      'type': instance.type,
      'duration': instance.duration,
      'property': instance.property,
    };
