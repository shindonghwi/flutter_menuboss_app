import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

part 'SimpleMediaContentModel.g.dart';

@JsonSerializable()
class SimpleMediaContentModel {
  final String? object;
  final String? id;
  final String? name;
  final String? type;
  final int? size;
  final int? count;
  final int? duration;
  final String? imageUrl;

  SimpleMediaContentModel({
    this.object,
    this.id,
    this.name,
    this.type,
    this.size = 0,
    this.count = 0,
    this.duration = 10,
    this.imageUrl,
  });

  factory SimpleMediaContentModel.fromJson(Map<String, dynamic> json) => _$SimpleMediaContentModelFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleMediaContentModelToJson(this);

  SimpleMediaContentModel copyWith({
    String? object,
    String? id,
    String? name,
    String? type,
    int? size,
    int? count,
    int? duration,
    String? imageUrl,
  }) {
    return SimpleMediaContentModel(
      object: object ?? this.object,
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      size: size ?? this.size,
      count: count ?? this.count,
      duration: duration ?? this.duration,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SimpleMediaContentModel &&
        other.object == object &&
        other.id == id &&
        other.name == name &&
        other.type == type &&
        other.size == size &&
        other.count == count &&
        other.duration == duration &&
        other.imageUrl == imageUrl;
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
