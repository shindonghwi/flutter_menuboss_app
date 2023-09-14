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
    this.count,
    this.width,
    this.height,
    this.size,
    this.duration,
    this.rotation,
    this.imageUrl,
    this.videoUrl,
  });

  factory ResponseMediaProperty.fromJson(Map<String, dynamic> json) => _$ResponseMediaPropertyFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMediaPropertyToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
