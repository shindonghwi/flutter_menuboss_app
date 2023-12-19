// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestScheduleUpdateInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestScheduleUpdateInfoModel _$RequestScheduleUpdateInfoModelFromJson(
        Map<String, dynamic> json) =>
    RequestScheduleUpdateInfoModel(
      name: json['name'] as String,
      plans: (json['plans'] as List<dynamic>?)
          ?.map((e) =>
              RequestScheduleUpdateInfoPlan.fromJson(e as Map<String, dynamic>))
          .toList(),
      playlists: (json['playlists'] as List<dynamic>?)
          ?.map((e) => RequestScheduleUpdateInfoPlaylist.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RequestScheduleUpdateInfoModelToJson(
        RequestScheduleUpdateInfoModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'playlists': instance.playlists,
      'plans': instance.plans,
    };
