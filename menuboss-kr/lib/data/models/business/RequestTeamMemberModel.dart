import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

part 'RequestTeamMemberModel.g.dart';

@JsonSerializable()
class RequestTeamMemberModel {
  final String email;
  final String name;
  final String password;
  final String country;
  final String phone;
  final int roleId;

  RequestTeamMemberModel({
    required this.email,
    required this.name,
    required this.password,
    required this.country,
    required this.phone,
    required this.roleId,
  });

  factory RequestTeamMemberModel.fromJson(Map<String, dynamic> json) =>
      _$RequestTeamMemberModelFromJson(json);

  RequestTeamMemberModel copyWith({
    String? email,
    String? name,
    String? password,
    String? country,
    String? phone,
    int? roleId,
  }) {
    return RequestTeamMemberModel(
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      country: country ?? this.country,
      phone: phone ?? this.phone,
      roleId: roleId ?? this.roleId,
    );
  }

  Map<String, dynamic> toJson() => _$RequestTeamMemberModelToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
