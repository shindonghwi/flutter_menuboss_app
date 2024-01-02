// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestMeSocialJoinModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestMeSocialJoinModel _$RequestMeSocialJoinModelFromJson(
        Map<String, dynamic> json) =>
    RequestMeSocialJoinModel(
      type: json['type'] as String,
      accessToken: json['accessToken'] as String,
      name: json['name'] as String?,
      business: json['business'] as String?,
      timeZone: json['timeZone'] as String?,
    );

Map<String, dynamic> _$RequestMeSocialJoinModelToJson(
        RequestMeSocialJoinModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'accessToken': instance.accessToken,
      'name': instance.name,
      'business': instance.business,
      'timeZone': instance.timeZone,
    };
