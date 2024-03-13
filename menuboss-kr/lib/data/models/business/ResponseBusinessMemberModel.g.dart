// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseBusinessMemberModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseBusinessMemberModel _$ResponseBusinessMemberModelFromJson(
        Map<String, dynamic> json) =>
    ResponseBusinessMemberModel(
      memberId: json['memberId'] as int,
      email: json['email'] as String,
      name: json['name'] as String,
      phone: json['phone'] == null
          ? null
          : ResponseMeBusinessPhone.fromJson(
              json['phone'] as Map<String, dynamic>),
      createdDate: json['createdDate'] as String,
      updatedDate: json['updatedDate'] as String,
      role: json['role'] == null
          ? null
          : ResponseBusinessMemberRole.fromJson(
              json['role'] as Map<String, dynamic>),
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      canEdit: json['canEdit'] as bool?,
      canDelete: json['canDelete'] as bool?,
    );

Map<String, dynamic> _$ResponseBusinessMemberModelToJson(
        ResponseBusinessMemberModel instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'createdDate': instance.createdDate,
      'updatedDate': instance.updatedDate,
      'role': instance.role,
      'permissions': instance.permissions,
      'canEdit': instance.canEdit,
      'canDelete': instance.canDelete,
    };
