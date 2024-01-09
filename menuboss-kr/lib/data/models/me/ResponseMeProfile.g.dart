// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseMeProfile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMeProfile _$ResponseMeProfileFromJson(Map<String, dynamic> json) =>
    ResponseMeProfile(
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$ResponseMeProfileToJson(ResponseMeProfile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'imageUrl': instance.imageUrl,
    };
