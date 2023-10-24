import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

import 'ResponseMediaProperty.dart';
import 'ResponseMediaPropertyInfo.dart';
import 'SimpleMediaContentModel.dart';

part 'ResponseMediaModel.g.dart';

@JsonSerializable()
class ResponseMediaModel {
  final String object;
  final String mediaId;
  final ResponseMediaPropertyInfo? type;
  final String? name;
  final ResponseMediaProperty? property;
  final String? createdDate;
  final String? updatedDate;

  ResponseMediaModel({
    this.object = "",
    this.mediaId = "",
    this.name = "",
    this.type,
    this.property,
    this.createdDate,
    this.updatedDate,
  });

  factory ResponseMediaModel.fromJson(Map<String, dynamic> json) => _$ResponseMediaModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMediaModelToJson(this);

  ResponseMediaModel copyWith({
    String? object,
    String? mediaId,
    String? name,
    ResponseMediaPropertyInfo? type,
    ResponseMediaProperty? property,
    String? createdDate,
    String? updatedDate,
  }) {
    return ResponseMediaModel(
      object: object ?? this.object,
      mediaId: mediaId ?? this.mediaId,
      name: name ?? this.name,
      type: type ?? this.type,
      property: property ?? this.property,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
    );
  }

  SimpleMediaContentModel toMapperMediaContentModel() {
    final model = SimpleMediaContentModel(
      index: -1,
      object: object,
      id: mediaId,
      name: name ?? "",
      type: type?.code ?? "",
      property: ResponseMediaProperty(
        count: property?.count ?? 0,
        width: property?.width ?? 0,
        height: property?.height ?? 0,
        size: property?.size ?? 0,
        duration: property?.duration ?? 10,
        rotation: property?.rotation ?? 0,
        imageUrl: property?.imageUrl ?? "",
        videoUrl: property?.videoUrl ?? "",
      )
    );
    return model;
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
