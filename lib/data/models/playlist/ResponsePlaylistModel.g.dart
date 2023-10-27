// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponsePlaylistModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponsePlaylistModel _$ResponsePlaylistModelFromJson(
        Map<String, dynamic> json) =>
    ResponsePlaylistModel(
      object: json['object'] as String,
      playlistId: json['playlistId'] as int,
      name: json['name'] as String,
      time: json['time'] == null
          ? null
          : ResponsePlaylistTime.fromJson(json['time'] as Map<String, dynamic>),
      property: json['property'] == null
          ? null
          : ResponsePlaylistProperty.fromJson(
              json['property'] as Map<String, dynamic>),
      contents: (json['contents'] as List<dynamic>?)
          ?.map((e) =>
              ResponsePlaylistContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      updatedDate: json['updatedDate'] as String,
    );

Map<String, dynamic> _$ResponsePlaylistModelToJson(
        ResponsePlaylistModel instance) =>
    <String, dynamic>{
      'object': instance.object,
      'playlistId': instance.playlistId,
      'name': instance.name,
      'time': instance.time,
      'property': instance.property,
      'contents': instance.contents,
      'updatedDate': instance.updatedDate,
    };
