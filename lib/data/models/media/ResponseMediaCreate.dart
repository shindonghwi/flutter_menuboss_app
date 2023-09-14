import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

import 'ResponseMediaFiles.dart';
import 'ResponseMediaProperty.dart';
import 'ResponseMediaPropertyInfo.dart';

part 'ResponseMediaCreate.g.dart';

@JsonSerializable()
class ResponseMediaCreate {
  final String? object;
  final String? mediaId;
  final String? type;
  final String? name;
  final ResponseMediaProperty? property;
  final List<ResponseMediaFiles>? files;
  final String? updatedAt;
  final String? createdAt;

  ResponseMediaCreate({
    this.object,
    this.mediaId,
    this.name,
    this.type,
    this.property,
    this.files,
    this.updatedAt,
    this.createdAt,
  });

  factory ResponseMediaCreate.fromJson(Map<String, dynamic> json) => _$ResponseMediaCreateFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMediaCreateToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
