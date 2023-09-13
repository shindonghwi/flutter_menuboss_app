// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponsePlaylistContents.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponsePlaylistContents _$ResponsePlaylistContentsFromJson(
        Map<String, dynamic> json) =>
    ResponsePlaylistContents(
      contentId: json['contentId'] as String,
      type: ResponsePlaylistPropertyInfo.fromJson(
          json['type'] as Map<String, dynamic>),
      duration: json['duration'] as int,
      size: json['size'] as int,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$ResponsePlaylistContentsToJson(
        ResponsePlaylistContents instance) =>
    <String, dynamic>{
      'contentId': instance.contentId,
      'type': instance.type,
      'duration': instance.duration,
      'size': instance.size,
      'imageUrl': instance.imageUrl,
    };
