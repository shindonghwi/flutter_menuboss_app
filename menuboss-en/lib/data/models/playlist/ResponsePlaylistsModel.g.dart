// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponsePlaylistsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponsePlaylistsModel _$ResponsePlaylistsModelFromJson(
        Map<String, dynamic> json) =>
    ResponsePlaylistsModel(
      object: json['object'] as String,
      playlistId: json['playlistId'] as int,
      name: json['name'] as String,
      time: json['time'] == null
          ? null
          : ResponsePlaylistTime.fromJson(json['time'] as Map<String, dynamic>),
      property: json['property'] == null
          ? null
          : ResponsePlaylistsProperty.fromJson(
              json['property'] as Map<String, dynamic>),
      updatedDate: json['updatedDate'] as String,
    );

Map<String, dynamic> _$ResponsePlaylistsModelToJson(
        ResponsePlaylistsModel instance) =>
    <String, dynamic>{
      'object': instance.object,
      'playlistId': instance.playlistId,
      'name': instance.name,
      'time': instance.time,
      'property': instance.property,
      'updatedDate': instance.updatedDate,
    };
