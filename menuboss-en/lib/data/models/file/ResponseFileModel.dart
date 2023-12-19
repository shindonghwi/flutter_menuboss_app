import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

part 'ResponseFileModel.g.dart';

@JsonSerializable()
class ResponseFileModel {
  final int imageId;

  ResponseFileModel({
    required this.imageId,
  });

  factory ResponseFileModel.fromJson(Map<String, dynamic> json) => _$ResponseFileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseFileModelToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
