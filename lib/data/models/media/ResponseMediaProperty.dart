import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

part 'ResponseMediaProperty.g.dart';

@JsonSerializable()
class ResponseMediaProperty {
  final int? count;
  final int? width;
  final int? height;
  final int? size;
  final int? duration;
  final int? rotation;
  final String? imageUrl;
  final String? videoUrl;

  ResponseMediaProperty({
    required this.count,
    required this.width,
    required this.height,
    required this.size,
    required this.duration,
    required this.rotation,
    required this.imageUrl,
    required this.videoUrl,
  });

  factory ResponseMediaProperty.fromJson(Map<String, dynamic> json) =>
      _$ResponseMediaPropertyFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMediaPropertyToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
