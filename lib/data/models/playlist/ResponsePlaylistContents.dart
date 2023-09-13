import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistPropertyInfo.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

import 'ResponsePlaylistProperty.dart';

part 'ResponsePlaylistContents.g.dart';

@JsonSerializable()
class ResponsePlaylistContents {
  final String contentId;
  final ResponsePlaylistPropertyInfo type;
  final int duration;
  final int size;
  final String? imageUrl;

  ResponsePlaylistContents({
    required this.contentId,
    required this.type,
    required this.duration,
    required this.size,
    required this.imageUrl,
  });

  factory ResponsePlaylistContents.fromJson(Map<String, dynamic> json) => _$ResponsePlaylistContentsFromJson(json);

  Map<String, dynamic> toJson() => _$ResponsePlaylistContentsToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
