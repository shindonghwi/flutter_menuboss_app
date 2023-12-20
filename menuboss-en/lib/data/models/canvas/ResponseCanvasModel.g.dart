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
      updatedDate: json['updatedDate'] as String?,
      createdDate: json['createdDate'] as String?,
    );

Map<String, dynamic> _$ResponseCanvasModelToJson(
        ResponseCanvasModel instance) =>
    <String, dynamic>{
      'object': instance.object,
      'canvasId': instance.canvasId,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'updatedDate': instance.updatedDate,
      'createdDate': instance.createdDate,
    };
