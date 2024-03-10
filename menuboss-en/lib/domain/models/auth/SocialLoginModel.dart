import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/domain/models/auth/LoginPlatform.dart';

part 'SocialLoginModel.g.dart';

@JsonSerializable()
class SocialLoginModel {
  final LoginPlatform loginPlatform;
  final String? accessToken;
  final String? email;

  SocialLoginModel(this.loginPlatform, this.accessToken, {this.email = ""}  );

  factory SocialLoginModel.fromJson(Map<String, dynamic> json) => _$SocialLoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$SocialLoginModelToJson(this);
}
