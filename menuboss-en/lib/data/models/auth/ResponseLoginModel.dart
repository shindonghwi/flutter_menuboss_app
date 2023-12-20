import 'package:json_annotation/json_annotation.dart';

part 'ResponseLoginModel.g.dart';

@JsonSerializable()
class ResponseLoginModel {
  final String accessToken;

  ResponseLoginModel({
    required this.accessToken,
  });

  factory ResponseLoginModel.fromJson(Map<String, dynamic> json) => _$ResponseLoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseLoginModelToJson(this);
}