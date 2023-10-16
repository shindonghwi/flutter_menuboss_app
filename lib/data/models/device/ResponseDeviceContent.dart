import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

part 'ResponseDeviceContent.g.dart';

@JsonSerializable()
class ResponseDeviceContent {
  final String? type;
  final String? name;
  final String? imageUrl;

  ResponseDeviceContent({
    required this.type,
    required this.name,
    required this.imageUrl,
  });

  factory ResponseDeviceContent.fromJson(Map<String, dynamic> json) => _$ResponseDeviceContentFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDeviceContentToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
