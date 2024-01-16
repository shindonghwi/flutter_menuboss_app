import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/data/models/me/ResponseMeBusinessAddress.dart';
import 'package:menuboss/data/models/me/ResponseMeBusinessCount.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

import 'ResponseMeBusinessPermissions.dart';

part 'ResponseMeBusiness.g.dart';

@JsonSerializable()
class ResponseMeBusiness {
  final String? title;
  final String? role;
  final ResponseMeBusinessCount? count;
  final ResponseMeBusinessAddress? address;
  final String? phone;
  final List<ResponseMeBusinessPermissions>? permissions;

  ResponseMeBusiness({
    required this.title,
    required this.role,
    required this.count,
    required this.address,
    required this.phone,
    required this.permissions,
  });

  factory ResponseMeBusiness.fromJson(Map<String, dynamic> json) =>
      _$ResponseMeBusinessFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeBusinessToJson(this);

  ResponseMeBusiness copyWith({
    String? title,
    String? role,
    ResponseMeBusinessCount? count,
    ResponseMeBusinessAddress? address,
    String? phone,
    List<ResponseMeBusinessPermissions>? permissions,
  }) {
    return ResponseMeBusiness(
      title: title ?? this.title,
      role: role ?? this.role,
      count: count ?? this.count,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      permissions: permissions ?? this.permissions,
    );
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
