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
      property: json['property'] == null
          ? null
          : ResponsePlaylistsProperty.fromJson(
              json['property'] as Map<String, dynamic>),
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$ResponsePlaylistsModelToJson(
        ResponsePlaylistsModel instance) =>
    <String, dynamic>{
      'object': instance.object,
      'playlistId': instance.playlistId,
      'name': instance.name,
      'property': instance.property,
      'updatedAt': instance.updatedAt,
    };
