// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestPlaylistUpdateInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestPlaylistUpdateInfoModel _$RequestPlaylistUpdateInfoModelFromJson(
        Map<String, dynamic> json) =>
    RequestPlaylistUpdateInfoModel(
      name: json['name'] as String,
      property: RequestPlaylistUpdateInfoProperty.fromJson(
          json['property'] as Map<String, dynamic>),
      contents: (json['contents'] as List<dynamic>)
          .map((e) => RequestPlaylistUpdateInfoContents.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RequestPlaylistUpdateInfoModelToJson(
        RequestPlaylistUpdateInfoModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'property': instance.property,
      'contents': instance.contents,
    };
