// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseMediaProperty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMediaProperty _$ResponseMediaPropertyFromJson(
        Map<String, dynamic> json) =>
    ResponseMediaProperty(
      count: json['count'] as int?,
      width: json['width'] as int?,
      height: json['height'] as int?,
      size: json['size'] as int?,
      duration: json['duration'] as int? ?? 10,
      rotation: json['rotation'] as int?,
      imageUrl: json['imageUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
    );

Map<String, dynamic> _$ResponseMediaPropertyToJson(
        ResponseMediaProperty instance) =>
    <String, dynamic>{
      'count': instance.count,
      'width': instance.width,
      'height': instance.height,
      'size': instance.size,
      'duration': instance.duration,
      'rotation': instance.rotation,
      'imageUrl': instance.imageUrl,
      'videoUrl': instance.videoUrl,
    };
