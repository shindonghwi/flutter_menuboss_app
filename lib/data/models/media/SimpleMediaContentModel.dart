import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

import 'ResponseMediaProperty.dart';

part 'SimpleMediaContentModel.g.dart';

@JsonSerializable()
class SimpleMediaContentModel {
  final int? index;
  final String? object;
  final String? id;
  final String? name;
  final String? type;
  final ResponseMediaProperty? property;
  final UniqueKey? uniqueKey;

  SimpleMediaContentModel({
    this.index,
    this.object,
    this.id,
    this.name,
    this.type,
    this.property,
    this.uniqueKey,
  });

  factory SimpleMediaContentModel.fromJson(Map<String, dynamic> json) => _$SimpleMediaContentModelFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleMediaContentModelToJson(this);

  SimpleMediaContentModel copyWith({
    int? index,
    String? object,
    String? id,
    String? name,
    String? type,
    ResponseMediaProperty? property,
    UniqueKey? uniqueKey,
  }) {
    return SimpleMediaContentModel(
      index: index ?? this.index,
      object: object ?? this.object,
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      property: property ?? this.property,
      uniqueKey: uniqueKey ?? this.uniqueKey,
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
        other.property == property &&
        other.uniqueKey == uniqueKey;
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
