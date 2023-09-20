// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestScheduleUpdateInfoPlan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestScheduleUpdateInfoPlan _$RequestScheduleUpdateInfoPlanFromJson(
        Map<String, dynamic> json) =>
    RequestScheduleUpdateInfoPlan(
      playlistId: json['playlistId'] as int,
      type: json['type'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );

Map<String, dynamic> _$RequestScheduleUpdateInfoPlanToJson(
        RequestScheduleUpdateInfoPlan instance) =>
    <String, dynamic>{
      'playlistId': instance.playlistId,
      'type': instance.type,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
