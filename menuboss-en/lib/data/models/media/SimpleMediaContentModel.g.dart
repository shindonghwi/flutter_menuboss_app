// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SimpleMediaContentModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleMediaContentModel _$SimpleMediaContentModelFromJson(
        Map<String, dynamic> json) =>
    SimpleMediaContentModel(
      index: json['index'] as int?,
      object: json['object'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      isFolder: json['isFolder'] as bool?,
      property: json['property'] == null
          ? null
          : ResponseMediaProperty.fromJson(
              json['property'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SimpleMediaContentModelToJson(
        SimpleMediaContentModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'object': instance.object,
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'isFolder': instance.isFolder,
      'property': instance.property,
    };
