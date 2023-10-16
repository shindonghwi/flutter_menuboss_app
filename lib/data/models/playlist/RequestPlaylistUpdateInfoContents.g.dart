// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestPlaylistUpdateInfoContents.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestPlaylistUpdateInfoContents _$RequestPlaylistUpdateInfoContentsFromJson(
        Map<String, dynamic> json) =>
    RequestPlaylistUpdateInfoContents(
      contentId: json['contentId'] as String,
      duration: (json['duration'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RequestPlaylistUpdateInfoContentsToJson(
        RequestPlaylistUpdateInfoContents instance) =>
    <String, dynamic>{
      'contentId': instance.contentId,
      'duration': instance.duration,
    };
