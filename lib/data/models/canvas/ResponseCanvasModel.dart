import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

part 'ResponseCanvasModel.g.dart';

@JsonSerializable()
class ResponseCanvasModel {
  final String object;
  final int canvasId;
  final String? name;
  final String? imageUrl;
  final String? updatedAt;
  final String? createdAt;

  ResponseCanvasModel({
    required this.object,
    required this.canvasId,
    required this.name,
    required this.imageUrl,
    required this.updatedAt,
    required this.createdAt,
  });

  factory ResponseCanvasModel.fromJson(Map<String, dynamic> json) => _$ResponseCanvasModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseCanvasModelToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
