// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseSchedulesModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseSchedulesModel _$ResponseSchedulesModelFromJson(
        Map<String, dynamic> json) =>
    ResponseSchedulesModel(
      object: json['object'] as String,
      scheduleId: json['scheduleId'] as int,
      name: json['name'] as String,
      property: json['property'] == null
          ? null
          : ResponseSchedulesProperty.fromJson(
              json['property'] as Map<String, dynamic>),
      playlists: (json['playlists'] as List<dynamic>?)
          ?.map(
              (e) => ResponsePlaylistModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$ResponseSchedulesModelToJson(
        ResponseSchedulesModel instance) =>
    <String, dynamic>{
      'object': instance.object,
      'scheduleId': instance.scheduleId,
      'name': instance.name,
      'property': instance.property,
      'playlists': instance.playlists,
      'updatedAt': instance.updatedAt,
    };
