import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

import 'ResponseMediaFiles.dart';
import 'ResponseMediaProperty.dart';
import 'ResponseMediaPropertyInfo.dart';

part 'ResponseMediaModel.g.dart';

@JsonSerializable()
class ResponseMediaModel {
  final String object;
  final String mediaId;
  final String? name;
  final ResponseMediaPropertyInfo? type;
  final ResponseMediaProperty? property;
  final ResponseMediaFiles? files;
  final int? size;
  final int? count;
  final String? thumbnailUrl;
  final String? createdAt;
  final String? updatedAt;

  ResponseMediaModel({
    this.object = "",
    this.mediaId = "",
    this.name = "",
    this.type,
    this.property,
    this.files,
    this.size = 0,
    this.count = 0,
    this.thumbnailUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory ResponseMediaModel.fromJson(Map<String, dynamic> json) => _$ResponseMediaModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMediaModelToJson(this);

  ResponseMediaModel copyWith({
    String? object,
    String? mediaId,
    String? name,
    ResponseMediaPropertyInfo? type,
    ResponseMediaProperty? property,
    ResponseMediaFiles? files,
    int? size,
    int? count,
    String? thumbnailUrl,
    String? createdAt,
    String? updatedAt,
  }) {
    return ResponseMediaModel(
      object: object ?? this.object,
      mediaId: mediaId ?? this.mediaId,
      name: name ?? this.name,
      type: type ?? this.type,
      property: property ?? this.property,
      files: files ?? this.files,
      size: size ?? this.size,
      count: count ?? this.count,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
