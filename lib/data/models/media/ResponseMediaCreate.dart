import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

import 'ResponseMediaFiles.dart';
import 'ResponseMediaProperty.dart';
import 'ResponseMediaPropertyInfo.dart';

part 'ResponseMediaCreate.g.dart';

@JsonSerializable()
class ResponseMediaCreate {
  final String object;
  final int mediaId;
  final String name;
  final String type;
  final ResponseMediaProperty? property;
  final String createdAt;

  ResponseMediaCreate({
    required this.object,
    required this.mediaId,
    required this.name,
    required this.type,
    required this.property,
    required this.createdAt,
  });

  factory ResponseMediaCreate.fromJson(Map<String, dynamic> json) => _$ResponseMediaCreateFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMediaCreateToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
