import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

part 'SimpleMediaContentModel.g.dart';
@JsonSerializable()

class SimpleMediaContentModel {
  final String object;
  final String mediaId;
  final String name;
  final String type;
  final int size;
  final int count;
  final String? thumbnailUrl;

  SimpleMediaContentModel({
    required this.object,
    required this.mediaId,
    required this.name,
    required this.type,
    this.size = 0,
    this.count = 0,
    this.thumbnailUrl,
  });

  factory SimpleMediaContentModel.fromJson(Map<String, dynamic> json) => _$SimpleMediaContentModelFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleMediaContentModelToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
