import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

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
  final String? createdAt;
  final String? updatedAt;

  ResponseMediaModel({
    this.object = "",
    this.mediaId = "",
    this.name = "",
    this.type,
    this.property,
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
    String? createdAt,
    String? updatedAt,
  }) {
    return ResponseMediaModel(
      object: object ?? this.object,
      mediaId: mediaId ?? this.mediaId,
      name: name ?? this.name,
      type: type ?? this.type,
      property: property ?? this.property,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  SimpleMediaContentModel toMapperMediaContentModel() {
    final model = SimpleMediaContentModel(
        index: -1,
        object: object,
        id: mediaId,
        name: name ?? "",
        type: type?.code ?? "",
        isFolder: type?.code.toLowerCase() == "folder",
        property: ResponseMediaProperty(
          count: property?.count ?? 0,
          width: property?.width ?? 0,
          height: property?.height ?? 0,
          size: property?.size ?? 0,
          duration: property?.duration ?? 10,
          rotation: property?.rotation ?? 0,
          imageUrl: property?.imageUrl ?? "",
          videoUrl: property?.videoUrl ?? "",
        ));
    return model;
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
