import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

part 'ResponseMeBusinessAddress.g.dart';

@JsonSerializable()
class ResponseMeBusinessAddress {
  final String? line1;
  final String? line2;
  final String? postalCode;

  ResponseMeBusinessAddress({
    required this.line1,
    required this.line2,
    required this.postalCode,
  });

  factory ResponseMeBusinessAddress.fromJson(Map<String, dynamic> json) =>
      _$ResponseMeBusinessAddressFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeBusinessAddressToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
