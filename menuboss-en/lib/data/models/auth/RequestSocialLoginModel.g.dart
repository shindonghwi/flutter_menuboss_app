// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestSocialLoginModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestSocialLoginModel _$RequestSocialLoginModelFromJson(
        Map<String, dynamic> json) =>
    RequestSocialLoginModel(
      type: json['type'] as String,
      accessToken: json['accessToken'] as String,
      deviceToken: json['deviceToken'] as String,
    );

Map<String, dynamic> _$RequestSocialLoginModelToJson(
        RequestSocialLoginModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'accessToken': instance.accessToken,
      'deviceToken': instance.deviceToken,
    };
