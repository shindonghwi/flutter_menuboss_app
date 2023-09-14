import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

import 'ResponseMediaFiles.dart';
import 'ResponseMediaProperty.dart';
import 'ResponseMediaPropertyInfo.dart';

part 'ResponseMediaModel.g.dart';

@JsonSerializable()
class ResponseMediaModel {
  final String object;
  final int mediaId;
  final String name;
  final ResponseMediaPropertyInfo? type;
  final ResponseMediaProperty? property;
  final ResponseMediaFiles? files;
  final int size;
  final String thumbnailUrl;
  final String createdAt;
  final String updatedAt;

  ResponseMediaModel({
    required this.object,
    required this.mediaId,
    required this.name,
    required this.type,
    required this.property,
    required this.files,
    required this.size,
    required this.thumbnailUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ResponseMediaModel.fromJson(Map<String, dynamic> json) => _$ResponseMediaModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMediaModelToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
