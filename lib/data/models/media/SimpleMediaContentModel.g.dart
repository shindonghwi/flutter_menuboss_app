// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SimpleMediaContentModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleMediaContentModel _$SimpleMediaContentModelFromJson(
        Map<String, dynamic> json) =>
    SimpleMediaContentModel(
      object: json['object'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      size: json['size'] as int? ?? 0,
      count: json['count'] as int? ?? 0,
      duration: json['duration'] as int? ?? 10,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$SimpleMediaContentModelToJson(
        SimpleMediaContentModel instance) =>
    <String, dynamic>{
      'object': instance.object,
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'size': instance.size,
      'count': instance.count,
      'duration': instance.duration,
      'imageUrl': instance.imageUrl,
    };
