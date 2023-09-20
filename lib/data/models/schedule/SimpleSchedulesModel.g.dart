// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SimpleSchedulesModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleSchedulesModel _$SimpleSchedulesModelFromJson(
        Map<String, dynamic> json) =>
    SimpleSchedulesModel(
      isRequired: json['isRequired'] as bool,
      isAddButton: json['isAddButton'] as bool,
      imageUrl: json['imageUrl'] as String,
      playlistId: json['playlistId'] as int?,
      playListName: json['playListName'] as String,
      start: json['start'] as String?,
      end: json['end'] as String?,
    );

Map<String, dynamic> _$SimpleSchedulesModelToJson(
        SimpleSchedulesModel instance) =>
    <String, dynamic>{
      'isRequired': instance.isRequired,
      'isAddButton': instance.isAddButton,
      'imageUrl': instance.imageUrl,
      'playlistId': instance.playlistId,
      'playListName': instance.playListName,
      'start': instance.start,
      'end': instance.end,
    };
