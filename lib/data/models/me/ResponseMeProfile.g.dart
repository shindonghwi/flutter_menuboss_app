// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseMeProfile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMeProfile _$ResponseMeProfileFromJson(Map<String, dynamic> json) =>
    ResponseMeProfile(
      name: json['name'] as String?,
      phone: json['phone'] == null
          ? null
          : ResponseMePhone.fromJson(json['phone'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseMeProfileToJson(ResponseMeProfile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
    };
