import 'package:json_annotation/json_annotation.dart';

part 'ResponseAppCheckUpModel.g.dart';

@JsonSerializable()
class ResponseAppCheckUpModel {
  final String latestVersion;

  ResponseAppCheckUpModel({
    required this.latestVersion,
  });

  factory ResponseAppCheckUpModel.fromJson(Map<String, dynamic> json) => _$ResponseAppCheckUpModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseAppCheckUpModelToJson(this);
}