// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestAddressModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestAddressModel _$RequestAddressModelFromJson(Map<String, dynamic> json) =>
    RequestAddressModel(
      country: json['country'] as String,
      line1: json['line1'] as String,
      line2: json['line2'] as String? ?? "",
      phone: json['phone'] as String,
      postalCode: json['postalCode'] as String,
    );

Map<String, dynamic> _$RequestAddressModelToJson(
        RequestAddressModel instance) =>
    <String, dynamic>{
      'country': instance.country,
      'line1': instance.line1,
      'line2': instance.line2,
      'phone': instance.phone,
      'postalCode': instance.postalCode,
    };
