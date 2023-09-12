// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseMeInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMeInfoModel _$ResponseMeInfoModelFromJson(Map<String, dynamic> json) =>
    ResponseMeInfoModel(
      memberId: json['memberId'] as int,
      email: json['email'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] == null
          ? null
          : ResponseMePhone.fromJson(json['phone'] as Map<String, dynamic>),
      business: json['business'] == null
          ? null
          : ResponseMeBusiness.fromJson(
              json['business'] as Map<String, dynamic>),
      authorization: json['authorization'] == null
          ? null
          : ResponseMeAuthorization.fromJson(
              json['authorization'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseMeInfoModelToJson(
        ResponseMeInfoModel instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'business': instance.business,
      'authorization': instance.authorization,
    };
