// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseMeInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMeInfoModel _$ResponseMeInfoModelFromJson(Map<String, dynamic> json) =>
    ResponseMeInfoModel(
      memberId: json['memberId'] as int,
      email: json['email'] as String?,
      profile: json['profile'] == null
          ? null
          : ResponseMeProfile.fromJson(json['profile'] as Map<String, dynamic>),
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
      'profile': instance.profile,
      'business': instance.business,
      'authorization': instance.authorization,
    };
