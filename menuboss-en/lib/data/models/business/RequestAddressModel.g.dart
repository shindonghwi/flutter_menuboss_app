// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestAddressModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestAddressModel _$RequestAddressModelFromJson(Map<String, dynamic> json) =>
    RequestAddressModel(
      country: json['country'] as String,
      city: json['city'] as String,
      line1: json['line1'] as String,
      postalCode: json['postalCode'] as String,
      phone: json['phone'] as String,
      state: json['state'] as String? ?? "",
      line2: json['line2'] as String? ?? "",
    );

Map<String, dynamic> _$RequestAddressModelToJson(
        RequestAddressModel instance) =>
    <String, dynamic>{
      'country': instance.country,
      'city': instance.city,
      'line1': instance.line1,
      'postalCode': instance.postalCode,
      'phone': instance.phone,
      'line2': instance.line2,
      'state': instance.state,
    };
