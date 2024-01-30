// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseMeBusinessAddress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMeBusinessAddress _$ResponseMeBusinessAddressFromJson(
        Map<String, dynamic> json) =>
    ResponseMeBusinessAddress(
      country: json['country'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      line1: json['line1'] as String?,
      line2: json['line2'] as String?,
      postalCode: json['postalCode'] as String?,
    );

Map<String, dynamic> _$ResponseMeBusinessAddressToJson(
        ResponseMeBusinessAddress instance) =>
    <String, dynamic>{
      'country': instance.country,
      'state': instance.state,
      'city': instance.city,
      'line1': instance.line1,
      'line2': instance.line2,
      'postalCode': instance.postalCode,
    };
