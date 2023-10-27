// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseScheduleModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseScheduleModel _$ResponseScheduleModelFromJson(
        Map<String, dynamic> json) =>
    ResponseScheduleModel(
      object: json['object'] as String,
      scheduleId: json['scheduleId'] as int,
      name: json['name'] as String,
      playlists: (json['playlists'] as List<dynamic>?)
          ?.map(
              (e) => ResponsePlaylistsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      updatedDate: json['updatedDate'] as String,
    );

Map<String, dynamic> _$ResponseScheduleModelToJson(
        ResponseScheduleModel instance) =>
    <String, dynamic>{
      'object': instance.object,
      'scheduleId': instance.scheduleId,
      'name': instance.name,
      'playlists': instance.playlists,
      'updatedDate': instance.updatedDate,
    };
