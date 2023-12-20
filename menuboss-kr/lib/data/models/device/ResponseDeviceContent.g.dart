// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseDeviceContent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseDeviceContent _$ResponseDeviceContentFromJson(
        Map<String, dynamic> json) =>
    ResponseDeviceContent(
      type: json['type'] as String?,
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$ResponseDeviceContentToJson(
        ResponseDeviceContent instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
    };
