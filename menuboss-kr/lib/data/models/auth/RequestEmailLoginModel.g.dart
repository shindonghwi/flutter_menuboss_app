// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestEmailLoginModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestEmailLoginModel _$RequestEmailLoginModelFromJson(
        Map<String, dynamic> json) =>
    RequestEmailLoginModel(
      email: json['email'] as String,
      password: json['password'] as String,
      deviceToken: json['deviceToken'] as String,
    );

Map<String, dynamic> _$RequestEmailLoginModelToJson(
        RequestEmailLoginModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'deviceToken': instance.deviceToken,
    };
