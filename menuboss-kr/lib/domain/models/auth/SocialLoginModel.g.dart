// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SocialLoginModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialLoginModel _$SocialLoginModelFromJson(Map<String, dynamic> json) =>
    SocialLoginModel(
      $enumDecode(_$LoginPlatformEnumMap, json['loginPlatform']),
      json['accessToken'] as String?,
    );

Map<String, dynamic> _$SocialLoginModelToJson(SocialLoginModel instance) =>
    <String, dynamic>{
      'loginPlatform': _$LoginPlatformEnumMap[instance.loginPlatform]!,
      'accessToken': instance.accessToken,
    };

const _$LoginPlatformEnumMap = {
  LoginPlatform.Google: 'Google',
  LoginPlatform.Kakao: 'Kakao',
  LoginPlatform.Apple: 'Apple',
  LoginPlatform.None: 'None',
};
