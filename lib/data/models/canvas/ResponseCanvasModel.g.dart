// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseCanvasModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseCanvasModel _$ResponseCanvasModelFromJson(Map<String, dynamic> json) =>
    ResponseCanvasModel(
      object: json['object'] as String,
      canvasId: json['canvasId'] as String,
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      updatedAt: json['updatedAt'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ResponseCanvasModelToJson(
        ResponseCanvasModel instance) =>
    <String, dynamic>{
      'object': instance.object,
      'canvasId': instance.canvasId,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
    };
