import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/data/models/business/ResponseBusinessMemberPhone.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

import 'ResponseBusinessMemberRole.dart';

part 'ResponseBusinessMemberModel.g.dart';

@JsonSerializable()
class ResponseBusinessMemberModel {
  final int memberId;
  final String email;
  final String name;
  final String? phone;
  final String createdDate;
  final String updatedDate;
  final ResponseBusinessMemberRole? role;
  final List<String>? permissions;
  final bool? canEdit;
  final bool? canDelete;

  ResponseBusinessMemberModel({
    required this.memberId,
    required this.email,
    required this.name,
    required this.phone,
    required this.createdDate,
    required this.updatedDate,
    required this.role,
    required this.permissions,
    required this.canEdit,
    required this.canDelete,
  });

  factory ResponseBusinessMemberModel.fromJson(Map<String, dynamic> json) => _$ResponseBusinessMemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBusinessMemberModelToJson(this);

  ResponseBusinessMemberModel copyWith({
    int? memberId,
    String? email,
    String? name,
    String? phone,
    String? createdDate,
    String? updatedDate,
    ResponseBusinessMemberRole? role,
    List<String>? permissions,
    bool? canEdit,
    bool? canDelete,
  }) {
    return ResponseBusinessMemberModel(
      memberId: memberId ?? this.memberId,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
      role: role ?? this.role,
      permissions: permissions ?? this.permissions,
      canEdit: canEdit ?? this.canEdit,
      canDelete: canDelete ?? this.canDelete,
    );
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
