import 'package:json_annotation/json_annotation.dart';

part 'RequestSocialLoginModel.g.dart';

@JsonSerializable()
class RequestSocialLoginModel {
  final String type;
  final String accessToken;
  final String deviceToken;

  RequestSocialLoginModel({
    required this.type,
    required this.accessToken,
    required this.deviceToken,
  });

  factory RequestSocialLoginModel.fromJson(Map<String, dynamic> json) => _$RequestSocialLoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestSocialLoginModelToJson(this);
}