import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/data/models/me/ResponseMeProfile.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

import 'ResponseMeAuthorization.dart';
import 'ResponseMeBusiness.dart';

part 'ResponseMeInfoModel.g.dart';

@JsonSerializable()
class ResponseMeInfoModel {
  final int memberId;
  final String? email;
  final ResponseMeProfile? profile;
  final ResponseMeBusiness? business;
  final ResponseMeAuthorization? authorization;

  ResponseMeInfoModel({
    required this.memberId,
    required this.email,
    required this.profile,
    required this.business,
    required this.authorization,
  });

  factory ResponseMeInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseMeInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeInfoModelToJson(this);

  ResponseMeInfoModel copyWith({
    String? email,
    ResponseMeProfile? profile,
    ResponseMeBusiness? business,
    ResponseMeAuthorization? authorization,
  }) {
    return ResponseMeInfoModel(
      memberId: memberId,
      email: email ?? this.email,
      profile: profile ?? this.profile,
      business: business ?? this.business,
      authorization: authorization ?? this.authorization,
    );
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
