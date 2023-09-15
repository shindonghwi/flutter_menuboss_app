// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseMediaFiles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMediaFiles _$ResponseMediaFilesFromJson(Map<String, dynamic> json) =>
    ResponseMediaFiles(
      object: json['object'] as String?,
      mediaId: json['mediaId'] as String?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      size: json['size'] as int?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ResponseMediaFilesToJson(ResponseMediaFiles instance) =>
    <String, dynamic>{
      'object': instance.object,
      'mediaId': instance.mediaId,
      'type': instance.type,
      'name': instance.name,
      'size': instance.size,
      'thumbnailUrl': instance.thumbnailUrl,
      'createdAt': instance.createdAt,
    };
