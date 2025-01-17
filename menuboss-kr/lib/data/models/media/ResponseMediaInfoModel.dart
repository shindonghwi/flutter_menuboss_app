import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

import 'ResponseMediaProperty.dart';
import 'ResponseMediaPropertyInfo.dart';

part 'ResponseMediaInfoModel.g.dart';

@JsonSerializable()
class ResponseMediaInfoModel {
  final String object;
  final String mediaId;
  final String? name;
  final ResponseMediaPropertyInfo? type;
  final ResponseMediaProperty? property;
  final String? updatedAt;

  ResponseMediaInfoModel({
    this.object = "",
    this.mediaId = "",
    this.name = "",
    this.type,
    this.property,
    this.updatedAt,
  });

  factory ResponseMediaInfoModel.fromJson(Map<String, dynamic> json) => _$ResponseMediaInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMediaInfoModelToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
