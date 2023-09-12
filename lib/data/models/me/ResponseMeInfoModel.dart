import 'package:json_annotation/json_annotation.dart';

import 'ResponseMeAuthorization.dart';
import 'ResponseMeBusiness.dart';
import 'ResponseMePhone.dart';

part 'ResponseMeInfoModel.g.dart';

@JsonSerializable()
class ResponseMeInfoModel {
  final String? memberId;
  final String? email;
  final String? name;
  final ResponseMePhone? phone;
  final ResponseMeBusiness? business;
  final ResponseMeAuthorization? authorization;

  ResponseMeInfoModel({
    required this.memberId,
    required this.email,
    required this.name,
    required this.phone,
    required this.business,
    required this.authorization,
  });

  factory ResponseMeInfoModel.fromJson(Map<String, dynamic> json) => _$ResponseMeInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeInfoModelToJson(this);

  ResponseMeInfoModel copyWith({
    String? memberId,
    String? email,
    String? name,
    ResponseMePhone? phone,
    ResponseMeBusiness? business,
    ResponseMeAuthorization? authorization,
  }) {
    return ResponseMeInfoModel(
      memberId: memberId ?? this.memberId,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      business: business ?? this.business,
      authorization: authorization ?? this.authorization,
    );
  }
}
