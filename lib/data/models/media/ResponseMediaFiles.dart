import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

part 'ResponseMediaFiles.g.dart';

@JsonSerializable()
class ResponseMediaFiles {
  final String? object;
  final String? mediaId;
  final String? type;
  final String? name;
  final int? size;
  final String? thumbnailUrl;
  final String? createdAt;

  ResponseMediaFiles({
    required this.object,
    required this.mediaId,
    required this.type,
    required this.name,
    required this.size,
    required this.thumbnailUrl,
    required this.createdAt,
  });

  factory ResponseMediaFiles.fromJson(Map<String, dynamic> json) =>
      _$ResponseMediaFilesFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMediaFilesToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
