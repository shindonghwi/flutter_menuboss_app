// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestDeviceApplyContents.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestDeviceApplyContents _$RequestDeviceApplyContentsFromJson(
        Map<String, dynamic> json) =>
    RequestDeviceApplyContents(
      screenIds: (json['screenIds'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
      contentType: json['contentType'] as String,
      contentId: json['contentId'] as int,
    );

Map<String, dynamic> _$RequestDeviceApplyContentsToJson(
        RequestDeviceApplyContents instance) =>
    <String, dynamic>{
      'screenIds': instance.screenIds,
      'contentType': instance.contentType,
      'contentId': instance.contentId,
    };
