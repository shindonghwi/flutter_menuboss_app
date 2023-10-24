import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/data/models/media/SimpleMediaContentModel.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

import '../media/ResponseMediaProperty.dart';

part 'ResponseCanvasModel.g.dart';

@JsonSerializable()
class ResponseCanvasModel {
  final String object;
  final String canvasId;
  final String? name;
  final String? imageUrl;
  final String? updatedDate;
  final String? createdDate;

  ResponseCanvasModel({
    required this.object,
    required this.canvasId,
    required this.name,
    required this.imageUrl,
    required this.updatedDate,
    required this.createdDate,
  });

  factory ResponseCanvasModel.fromJson(Map<String, dynamic> json) => _$ResponseCanvasModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseCanvasModelToJson(this);

  SimpleMediaContentModel toMapperMediaContentModel() {
    final model = SimpleMediaContentModel(
      object: object,
      id: canvasId,
      name: name ?? "",
      type: "canvas",
      property: ResponseMediaProperty(
        size: 0,
        duration: 10,
        imageUrl: imageUrl ?? "",
      ),
    );

    debugPrint("model: ${model.toString()}");

    return model;
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
