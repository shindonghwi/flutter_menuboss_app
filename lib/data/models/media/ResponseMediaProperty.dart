import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

part 'ResponseMediaProperty.g.dart';

@JsonSerializable()
class ResponseMediaProperty {
  final int? count;
  final int? width;
  final int? height;
  final int? size;
  final double? duration;
  final int? rotation;
  final String? codec;
  final String? contentType;
  final String? imageUrl;
  final String? videoUrl;

  ResponseMediaProperty({
    this.count,
    this.width,
    this.height,
    this.size,
    this.duration = 10,
    this.rotation,
    this.codec,
    this.contentType,
    this.imageUrl,
    this.videoUrl,
  });

  factory ResponseMediaProperty.fromJson(Map<String, dynamic> json) => _$ResponseMediaPropertyFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMediaPropertyToJson(this);

  ResponseMediaProperty copyWith({
    int? count,
    int? width,
    int? height,
    int? size,
    double? duration,
    int? rotation,
    String? contentType,
    String? imageUrl,
    String? videoUrl,
  }) {
    return ResponseMediaProperty(
      count: count ?? this.count,
      width: width ?? this.width,
      height: height ?? this.height,
      size: size ?? this.size,
      duration: duration ?? this.duration,
      rotation: rotation ?? this.rotation,
      contentType: contentType ?? this.contentType,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
