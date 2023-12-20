import 'package:json_annotation/json_annotation.dart';

part 'RequestEmailLoginModel.g.dart';

@JsonSerializable()
class RequestEmailLoginModel {
  final String email;
  final String password;
  final String deviceToken;

  RequestEmailLoginModel({
    required this.email,
    required this.password,
    required this.deviceToken,
  });

  factory RequestEmailLoginModel.fromJson(Map<String, dynamic> json) => _$RequestEmailLoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestEmailLoginModelToJson(this);
}