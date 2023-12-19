// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestPlaylistUpdateInfoProperty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestPlaylistUpdateInfoProperty _$RequestPlaylistUpdateInfoPropertyFromJson(
        Map<String, dynamic> json) =>
    RequestPlaylistUpdateInfoProperty(
      direction: json['direction'] as String? ?? "Horizontal",
      fill: json['fill'] as String? ?? "Fill",
    );

Map<String, dynamic> _$RequestPlaylistUpdateInfoPropertyToJson(
        RequestPlaylistUpdateInfoProperty instance) =>
    <String, dynamic>{
      'direction': instance.direction,
      'fill': instance.fill,
    };
