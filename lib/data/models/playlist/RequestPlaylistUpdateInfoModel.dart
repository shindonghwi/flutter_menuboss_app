import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

import 'RequestPlaylistUpdateInfoContents.dart';
import 'RequestPlaylistUpdateInfoProperty.dart';

part 'RequestPlaylistUpdateInfoModel.g.dart';

@JsonSerializable()
class RequestPlaylistUpdateInfoModel {
  final String name;
  final RequestPlaylistUpdateInfoProperty property;
  final List<RequestPlaylistUpdateInfoContents> contents;

  RequestPlaylistUpdateInfoModel({
    required this.name,
    required this.property,
    required this.contents,
  });

  factory RequestPlaylistUpdateInfoModel.fromJson(Map<String, dynamic> json) =>
      _$RequestPlaylistUpdateInfoModelFromJson(json);

  RequestPlaylistUpdateInfoModel copyWith({
    String? name,
    RequestPlaylistUpdateInfoProperty? property,
    List<RequestPlaylistUpdateInfoContents>? contents,
  }) {
    return RequestPlaylistUpdateInfoModel(
      name: name ?? this.name,
      property: property ?? this.property,
      contents: contents ?? this.contents,
    );
  }

  bool isCreateAvailable() {
    if (name.isEmpty) return false;
    if (property.direction.isEmpty) return false;
    if (property.fill.isEmpty) return false;
    if (contents.isEmpty) return false;
    return true;
  }

  Map<String, dynamic> toJson() => _$RequestPlaylistUpdateInfoModelToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }

}
