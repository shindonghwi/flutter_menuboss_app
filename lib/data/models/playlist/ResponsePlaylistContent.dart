import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/data/models/media/ResponseMediaProperty.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistPropertyInfo.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

import '../media/SimpleMediaContentModel.dart';
import 'ResponsePlaylistContentProperty.dart';

part 'ResponsePlaylistContent.g.dart';

@JsonSerializable()
class ResponsePlaylistContent {
  final String contentId;
  final String name;
  final ResponsePlaylistPropertyInfo type;
  final int duration;
  final ResponsePlaylistContentProperty property;

  ResponsePlaylistContent({
    required this.contentId,
    required this.name,
    required this.type,
    required this.duration,
    required this.property,
  });

  factory ResponsePlaylistContent.fromJson(Map<String, dynamic> json) => _$ResponsePlaylistContentFromJson(json);

  Map<String, dynamic> toJson() => _$ResponsePlaylistContentToJson(this);

  SimpleMediaContentModel toMapperMediaContentModel() {
    final model = SimpleMediaContentModel(
      object: "media_list",
      id: contentId,
      name: name,
      type: type.code,
      property: ResponseMediaProperty(
        size: property.size,
        duration: duration,
        imageUrl: property.imageUrl,
      ),
    );
    return model;
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
