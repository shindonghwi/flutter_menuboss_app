// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestMeJoinModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestMeJoinModel _$RequestMeJoinModelFromJson(Map<String, dynamic> json) =>
    RequestMeJoinModel(
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      business: json['business'] as String,
      timeZone: json['timeZone'] as String,
    );

Map<String, dynamic> _$RequestMeJoinModelToJson(RequestMeJoinModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'password': instance.password,
      'business': instance.business,
      'timeZone': instance.timeZone,
    };
