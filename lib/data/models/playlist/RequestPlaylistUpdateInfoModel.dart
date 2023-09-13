import 'package:json_annotation/json_annotation.dart';

import 'RequestPlaylistUpdateInfoContents.dart';
import 'RequestPlaylistUpdateInfoProperty.dart';

part 'RequestPlaylistUpdateInfoModel.g.dart';

@JsonSerializable()
class RequestPlaylistUpdateInfoModel {
  final RequestPlaylistUpdateInfoProperty property;
  final List<RequestPlaylistUpdateInfoContents> contents;

  RequestPlaylistUpdateInfoModel({
    required this.property,
    required this.contents,
  });

  factory RequestPlaylistUpdateInfoModel.fromJson(Map<String, dynamic> json) => _$RequestPlaylistUpdateInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestPlaylistUpdateInfoModelToJson(this);
}