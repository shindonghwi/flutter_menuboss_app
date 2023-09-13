import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

import 'ResponseDeviceContent.dart';

part 'ResponseDeviceModel.g.dart';

@JsonSerializable()
class ResponseDeviceModel {
  final String object;
  final String name;
  final ResponseDeviceContent? content;
  final int screenId;
  final bool isOnline;

  ResponseDeviceModel({
    required this.object,
    required this.name,
    required this.content,
    required this.screenId,
    required this.isOnline,
  });

  factory ResponseDeviceModel.fromJson(Map<String, dynamic> json) => _$ResponseDeviceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDeviceModelToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
