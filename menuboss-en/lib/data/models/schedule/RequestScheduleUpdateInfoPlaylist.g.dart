// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestScheduleUpdateInfoPlaylist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestScheduleUpdateInfoPlaylist _$RequestScheduleUpdateInfoPlaylistFromJson(
        Map<String, dynamic> json) =>
    RequestScheduleUpdateInfoPlaylist(
      playlistId: json['playlistId'] as int,
      time: json['time'] == null
          ? null
          : ResponsePlaylistTime.fromJson(json['time'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RequestScheduleUpdateInfoPlaylistToJson(
        RequestScheduleUpdateInfoPlaylist instance) =>
    <String, dynamic>{
      'playlistId': instance.playlistId,
      'time': instance.time,
    };
