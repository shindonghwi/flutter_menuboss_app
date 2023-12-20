// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseDeviceModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseDeviceModel _$ResponseDeviceModelFromJson(Map<String, dynamic> json) =>
    ResponseDeviceModel(
      object: json['object'] as String,
      name: json['name'] as String,
      content: json['content'] == null
          ? null
          : ResponseDeviceContent.fromJson(
              json['content'] as Map<String, dynamic>),
      screenId: json['screenId'] as int,
      isOnline: json['isOnline'] as bool,
    );

Map<String, dynamic> _$ResponseDeviceModelToJson(
        ResponseDeviceModel instance) =>
    <String, dynamic>{
      'object': instance.object,
      'name': instance.name,
      'content': instance.content,
      'screenId': instance.screenId,
      'isOnline': instance.isOnline,
    };
