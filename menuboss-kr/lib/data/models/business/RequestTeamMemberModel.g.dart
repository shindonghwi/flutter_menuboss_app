// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestTeamMemberModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestTeamMemberModel _$RequestTeamMemberModelFromJson(
        Map<String, dynamic> json) =>
    RequestTeamMemberModel(
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String,
      roleId: json['roleId'] as int,
    );

Map<String, dynamic> _$RequestTeamMemberModelToJson(
        RequestTeamMemberModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'password': instance.password,
      'phone': instance.phone,
      'roleId': instance.roleId,
    };
